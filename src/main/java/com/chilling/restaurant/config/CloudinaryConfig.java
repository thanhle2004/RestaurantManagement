package com.chilling.restaurant.config;

import com.cloudinary.Cloudinary;
import java.util.HashMap;
import java.util.Map;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {

    @Bean
    public Cloudinary cloudinary() {
        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", "dgmhg5oi4");
        config.put("api_key", "466185731953851");
        config.put("api_secret", "UAK80EwU70sE-YTU0Ujv3sLRAbs");
        return new Cloudinary(config);
    }
}
