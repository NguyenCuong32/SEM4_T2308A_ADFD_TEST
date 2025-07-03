package org.fai.study.travelapi.model;

import jakarta.persistence.*;

@Entity
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String image;

    // Constructor mặc định (bắt buộc cho JPA)
    public Place() {}

    // Constructor đầy đủ
    public Place(Long id, String name, String image) {
        this.id = id;
        this.name = name;
        this.image = image;
    }

    // Getter và Setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
