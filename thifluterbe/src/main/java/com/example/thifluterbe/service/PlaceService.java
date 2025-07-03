package com.example.thifluterbe.service;

import com.example.thifluterbe.model.Place;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PlaceService {
    public List<Place> getAllPlaces() {
        List<Place> places = new ArrayList<>();
        places.add(new Place("Hoi An", "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80", 4.0));
        places.add(new Place("Sai Gon", "https://images.unsplash.com/photo-1465156799763-2c087c332922?auto=format&fit=crop&w=400&q=80", 4.5));
        places.add(new Place("Dragon Bridge", "https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80", 4.2));
        places.add(new Place("Fansipan", "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80", 4.7));
        return places;
    }
} 