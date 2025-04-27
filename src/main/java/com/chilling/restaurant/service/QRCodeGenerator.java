package com.chilling.restaurant.service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class QRCodeGenerator {

    public static void generateQRCode(String data, String filePath) throws Exception {
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.MARGIN, 1);

        BitMatrix bitMatrix = new MultiFormatWriter()
            .encode(data, BarcodeFormat.QR_CODE, 300, 300, hints);

        File file = new File(filePath);
        MatrixToImageWriter.writeToFile(bitMatrix, "PNG", file);
    }
}