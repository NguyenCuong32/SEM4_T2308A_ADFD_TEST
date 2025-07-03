package org.example.travelapi.Repository;

import org.example.travelapi.Entity.Place;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlaceRepository extends JpaRepository<Place, Long> {}
