/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.config.CloudinaryConfig;
import com.chilling.restaurant.controller.MenuItemController;
import com.chilling.restaurant.model.MenuItem;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Map;

@WebServlet("/manager/menu-update")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class MenuUpdateServlet extends HttpServlet {

    private final Cloudinary cloudinary = CloudinaryConfig.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int itemId = Integer.parseInt(request.getParameter("id"));
            String itemName = request.getParameter("name");
            String itemType = request.getParameter("type");
            String itemPriceStr = request.getParameter("price");
            int itemTimeCook = Integer.parseInt(request.getParameter("time"));
            // Kiểm tra dữ liệu đầu vào
            if (itemName == null || itemName.isEmpty() || itemType == null || itemType.isEmpty() || itemPriceStr == null || itemPriceStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
                return;
            }

            double itemPrice = Double.parseDouble(itemPriceStr);

            // Lấy thông tin món cũ để có public_id
            MenuItemController controller = new MenuItemController();
            MenuItem existingItem = controller.getItemById(itemId);

            String imageUrl = existingItem.getItemImgPath();
            String publicId = existingItem.getItemImgPublicId();

            // Kiểm tra xem người dùng có upload ảnh mới không
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {
                // Ghi tạm file ảnh mới
                java.io.File tempFile = java.io.File.createTempFile("upload_", fileName);
                filePart.write(tempFile.getAbsolutePath());

                // Upload và ghi đè ảnh cũ bằng public_id cũ
                Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap(
                        "public_id", publicId,
                        "overwrite", true,
                        "invalidate", true
                ));

                tempFile.delete();

                imageUrl = (String) uploadResult.get("secure_url");
                // publicId giữ nguyên
            }

            // Cập nhật thông tin món ăn
            MenuItem updatedItem = new MenuItem();
            updatedItem.setItemId(itemId);
            updatedItem.setItemName(itemName);
            updatedItem.setItemType(itemType);
            updatedItem.setItemPrice(itemPrice);
            updatedItem.setItemTimeCook(itemTimeCook);
            updatedItem.setItemImgPath(imageUrl);
            updatedItem.setItemImgPublicId(publicId);

            controller.updateMenuItem(updatedItem);

            response.sendRedirect("menu-management");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Update failed");
        }
    }
}

