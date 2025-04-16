package com.chilling.restaurant.servlet;

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


@WebServlet("/manager/menu-item-create")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class MenuItemCreateServlet extends HttpServlet {
    
    private final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dgmhg5oi4",
            "api_key", "466185731953851",
            "api_secret", "UAK80EwU70sE-YTU0Ujv3sLRAbs"
    ));
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            String itemName = request.getParameter("name");
            String itemType = request.getParameter("type");
            String itemPriceStr = request.getParameter("price");

            if (itemName == null || itemPriceStr == null || itemType == null || itemName.isEmpty() || itemPriceStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "You must fill all information");
                return;
            }

            double itemPrice = Double.parseDouble(itemPriceStr);

            Part filePart = request.getPart("image");

            java.io.File tempFile = java.io.File.createTempFile("upload_", filePart.getSubmittedFileName());

            filePart.write(tempFile.getAbsolutePath());

            Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap(
                    "resource_type", "auto"
            ));

            tempFile.delete();

            String imageUrl = (String) uploadResult.get("secure_url");
            String publicId = (String) uploadResult.get("public_id");

            MenuItem newItem = new MenuItem();
            newItem.setItemName(itemName);
            newItem.setItemType(itemType);
            newItem.setItemPrice(itemPrice);
            newItem.setItemImgPath(imageUrl);
            newItem.setItemImgPublicId(publicId);

            MenuItemController controller = new MenuItemController();
            controller.addMenuItem(newItem);

            response.sendRedirect("menu-management");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while uploading item");
        }
    }
}
