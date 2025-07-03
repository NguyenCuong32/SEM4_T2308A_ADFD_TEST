package org.fai.study.travelapi.repository;

import org.fai.study.travelapi.model.Place;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlaceRepository extends JpaRepository<Place, Long> {
}
