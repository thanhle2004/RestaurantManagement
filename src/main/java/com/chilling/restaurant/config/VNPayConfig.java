package com.chilling.restaurant.config;

import jakarta.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class VNPayConfig {
    
    public static String vnp_Version = "2.1.0";
    public static String vnp_Command = "pay";
    public static String vnp_TmnCode = "NP7AX2ZW";  // Mã Website trên VNPAY
    public static String vnp_HashSecret = "VIOD50766ZQ01DZWD5JGMO3L0I3PCRZX"; // Chuỗi bí mật
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"; // URL VNPAY
    public static String vnp_ReturnUrl = "http://localhost:8080/restaurant/table/vnpay-return.jsp"; // URL người dùng sẽ quay về sau thanh toán
    
    public static String getIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress;
    }
    
    public static String hashAllFields(Map<String, String> fields) throws UnsupportedEncodingException {
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String name : fieldNames) {
            String value = fields.get(name);
            if ((value != null) && (value.length() > 0)) {
                // Build hashData
                hashData.append(name);
                hashData.append('=');
                hashData.append(URLEncoder.encode(value, "UTF-8"));
                hashData.append('&');

                // Build query
                query.append(name);
                query.append('=');
                query.append(URLEncoder.encode(value, "UTF-8"));
                query.append('&');
            }
        }

        if (hashData.length() > 0) {
            hashData.deleteCharAt(hashData.length() - 1);
        }
        if (query.length() > 0) {
            query.deleteCharAt(query.length() - 1);
        }

        // Debugging: In ra giá trị hashData
        System.out.println("Hash Data: " + hashData.toString());

        String secureHash = hmacSHA512(vnp_HashSecret, hashData.toString());

        // Debugging: In ra giá trị mã băm
        System.out.println("Secure Hash: " + secureHash);

        query.append("&vnp_SecureHash=").append(secureHash);

        return query.toString();
    }


    public static String hmacSHA512(String key, String data) {
        try {
            if (key == null || data == null) {
                return null;
            }
            byte[] hmacKeyBytes = key.getBytes("UTF-8");
            javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA512");
            javax.crypto.spec.SecretKeySpec secretKeySpec = new javax.crypto.spec.SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            mac.init(secretKeySpec);
            byte[] dataBytes = data.getBytes("UTF-8");
            byte[] result = mac.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception ex) {
            return "";
        }
    }
}
