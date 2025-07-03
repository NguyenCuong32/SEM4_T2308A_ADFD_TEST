package com.example.demo.controller;

import com.example.demo.model.Place;
import com.example.demo.repository.PlaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/places")
@CrossOrigin(origins = "*") // Cho phép frontend Flutter gọi API
public class PlaceController {

    @Autowired
    private PlaceRepository placeRepository;

    @GetMapping
    public List<Place> getAllPlaces() {
        return placeRepository.findAll();
    }

    // Optional: thêm endpoint để khởi tạo dữ liệu mẫu
    @PostMapping("/init")
    public void addSamplePlaces() {
        placeRepository.save(new Place("Đà Lạt", "https://example.com/dalat.jpg"));
        placeRepository.save(new Place("Hội An", "https://example.com/hoian.jpg"));
        placeRepository.save(new Place("Nha Trang", "https://example.com/nhatrang.jpg"));
    }
}
