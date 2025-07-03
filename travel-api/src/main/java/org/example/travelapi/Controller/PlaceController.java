package org.example.travelapi.Controller;

import org.example.travelapi.Entity.Place;
import org.example.travelapi.Service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/places")
@RequiredArgsConstructor
public class PlaceController {

    private final PlaceService placeService;

    @GetMapping
    public List<Place> getAllPlace() {
        return placeService.getAllPlaces();
    }
}
