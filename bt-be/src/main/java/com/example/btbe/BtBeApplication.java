package com.example.btbe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class BtBeApplication {

    public static void main(String[] args) {
        SpringApplication.run(BtBeApplication.class, args);
    }

    @Bean
    CommandLineRunner initData(PlaceRepository placeRepository) {
        return args -> {
            placeRepository.save(new Place("Hoi An", "https://your-image-url.com/hoian.jpg"));
            placeRepository.save(new Place("Sai Gon", "https://your-image-url.com/saigon.jpg"));
        };
    }

}
