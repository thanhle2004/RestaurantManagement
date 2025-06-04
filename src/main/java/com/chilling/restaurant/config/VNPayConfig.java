package com.chilling.restaurant.config;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

public class VNPayConfig {

    public static String vnp_Version = "2.1.0";
    public static String vnp_Command = "pay";
    public static String vnp_TmnCode;
    public static String vnp_HashSecret;
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:8080/restaurant/table/vnpay-return.jsp";

    static {
        try (InputStream input = VNPayConfig.class.getClassLoader().getResourceAsStream("vnpay.properties")) {
            Properties prop = new Properties();
            if (input != null) {
                prop.load(input);
                vnp_TmnCode = prop.getProperty("vnp_TmnCode");
                vnp_HashSecret = prop.getProperty("vnp_HashSecret");
            } else {
                throw new RuntimeException("Not found file vnpay.properties");
            }
        } catch (IOException ex) {
            throw new RuntimeException("Fail to read vnpay.properties", ex);
        }
    }

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
            if (value != null && value.length() > 0) {
                hashData.append(name).append('=').append(URLEncoder.encode(value, "UTF-8")).append('&');
                query.append(name).append('=').append(URLEncoder.encode(value, "UTF-8")).append('&');
            }
        }

        if (hashData.length() > 0) hashData.setLength(hashData.length() - 1);
        if (query.length() > 0) query.setLength(query.length() - 1);

        String secureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        return query.toString();
    }

    public static String hmacSHA512(String key, String data) {
        try {
            if (key == null || data == null) return null;
            byte[] hmacKeyBytes = key.getBytes("UTF-8");
            javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA512");
            javax.crypto.spec.SecretKeySpec secretKeySpec = new javax.crypto.spec.SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            mac.init(secretKeySpec);
            byte[] result = mac.doFinal(data.getBytes("UTF-8"));
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
