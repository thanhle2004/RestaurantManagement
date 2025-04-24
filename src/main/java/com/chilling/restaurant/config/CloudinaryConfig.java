package com.chilling.restaurant.config;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.IOException;
import java.util.Properties;
import java.io.InputStream;

public class CloudinaryConfig {
    public static Cloudinary getInstance() {
        try (InputStream input = CloudinaryConfig.class.getClassLoader().getResourceAsStream("cloudinary.properties")) {
            Properties prop = new Properties();
            prop.load(input);

            return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", prop.getProperty("cloud_name"),
                "api_key", prop.getProperty("api_key"),
                "api_secret", prop.getProperty("api_secret")
            ));
        } catch (IOException e) {
            throw new RuntimeException("Failed to load Cloudinary config", e);
        }
    }
}
