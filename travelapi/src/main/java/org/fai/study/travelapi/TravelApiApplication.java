package org.fai.study.travelapi;

import org.fai.study.travelapi.model.Place;
import org.fai.study.travelapi.repository.PlaceRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class TravelApiApplication {
    public static void main(String[] args) {
        SpringApplication.run(TravelApiApplication.class, args);
    }

    @Bean
    CommandLineRunner init(PlaceRepository repo) {
        return args -> {
            repo.save(new Place(null, "Hội An", "https://cdn2.ivivu.com/2022/05/Hoi-An-ivivu.jpg"));
            repo.save(new Place(null, "Sài Gòn", "https://cdn2.ivivu.com/2022/04/sg.jpeg"));
            repo.save(new Place(null, "Đà Lạt", "https://cdn2.ivivu.com/2022/03/dalat.jpg"));
        };
    }
}
