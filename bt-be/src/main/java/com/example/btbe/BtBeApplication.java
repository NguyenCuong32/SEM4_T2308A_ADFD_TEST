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
            placeRepository.save(new Place("Lao Cai", "https://scontent.iocvnpt.com/resources/portal/Images/LCI/superadminportal.lci/Tin%20tuc%20tp%20lao%20cai/XD%20van%20hoa/1_382613871.jpg"));
            placeRepository.save(new Place("Hoi An", "https://www.bambooairways.com/documents/20122/1165110/kinh-nghiem-du-lich-hoi-an-1.jpg/05c3f051-1623-c052-7a25-40a77f385ccf?t=1695007973161"));
            placeRepository.save(new Place("Sai Gon", "https://res.klook.com/image/upload/q_85/c_fill,w_750/v1697703032/qzuimwswvmcmp2wgqvmb.jpg"));
            placeRepository.save(new Place("Thanh Hoa", "https://cdn.nhandan.vn/images/4655dea7deebadd3e7b51fbe3a4f19d5debfb428da2d7886ce9028169019d82bd1a7ea749d6c13f68a7e671e4e0b4d35/thanhhoa.jpg"));
            placeRepository.save(new Place("Hai Phong", "https://xdcs.cdnchinhphu.vn/446259493575335936/2023/3/31/hai-phong-6-1680234763392125722891.jpg"));
            placeRepository.save(new Place("Hung Yen", "https://ddk.1cdn.vn/2023/12/28/hung-yen.jpg"));
        };
    }

}
