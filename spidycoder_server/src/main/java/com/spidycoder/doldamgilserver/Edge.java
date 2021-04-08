package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@Entity(name = "edge")
@IdClass(Edge.PK.class)
public class Edge {
    @Id @ManyToOne
    @JsonBackReference
    private Gym gym;

    @Id @Column(name = "code")
    private Long code;

    @Column(name = "description", nullable = false, columnDefinition = "varchar(100) default ''")
    private String description;

    @OneToMany(mappedBy = "edge")
    @JsonManagedReference
    private List<Wall> walls;

    @Data @NoArgsConstructor @AllArgsConstructor
    public static class PK implements Serializable {
        private Gym gym;
        private Long code;
    }
}
