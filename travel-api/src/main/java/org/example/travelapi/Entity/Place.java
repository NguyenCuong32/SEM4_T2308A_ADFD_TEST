package org.example.travelapi.Entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "places")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Place {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private String imageUrl;
}
