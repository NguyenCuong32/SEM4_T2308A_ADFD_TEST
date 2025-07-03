package org.fai.study.travelapi.controller;

import org.fai.study.travelapi.model.Place;
import org.fai.study.travelapi.repository.PlaceRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/places")
@CrossOrigin(origins = "*")
public class PlaceController {

    private final PlaceRepository repo;

    public PlaceController(PlaceRepository repo) {
        this.repo = repo;
    }

    @GetMapping
    public List<Place> getAllPlaces() {
        return repo.findAll();
    }
}
