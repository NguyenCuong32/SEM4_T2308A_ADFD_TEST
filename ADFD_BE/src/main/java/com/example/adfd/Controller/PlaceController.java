package com.example.adfd.Controller;

import com.example.adfd.Model.Place;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@CrossOrigin(origins = "*") // Thêm dòng này!
@RestController
@RequestMapping("/api/places")
public class PlaceController {
    @GetMapping
    public List<Place> getAllPlace() {
        return Arrays.asList(
                new Place(1L, "Hà Nội", "https://example.com/hn.jpg", "Thủ đô Việt Nam"),
                new Place(2L, "Đà Nẵng", "https://example.com/dn.jpg", "Thành phố biển miền Trung"),
                new Place(3L, "Hồ Chí Minh", "https://example.com/hcm.jpg", "Thành phố lớn nhất Việt Nam")
        );

    }
}