package org.example.travelapi.controller;

import org.example.travelapi.model.Place;
import org.example.travelapi.repository.PlaceRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api")
public class PlaceController {

    private final PlaceRepository repository;

    public PlaceController(PlaceRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/places")
    public List<Place> getAllPlaces() {
        return repository.findAll();
    }

    @PostMapping("/places")
    public Place addPlace(@RequestBody Place place) {
        return repository.save(place);
    }
}
