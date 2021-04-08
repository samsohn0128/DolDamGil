package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.List;

@Data
@Entity(name = "wall")
@IdClass(Wall.PK.class)
public class Wall {
    @Id @Column(name = "gym_id")
    private Long gymId;

    @Id @Column(name = "edge_code")
    private Long edgeCode;

    @Id @Column(name = "creation_time", columnDefinition = "default current_timestamp()")
    private OffsetDateTime creationTime;

    @ManyToOne
    @JoinColumn(name = "gym_id", referencedColumnName = "gym_id", insertable = false, updatable = false)
    @JoinColumn(name = "edge_code", referencedColumnName = "code", insertable = false, updatable = false)
    @JsonBackReference
    private Edge edge;

    private String picture;

    private String holdDoc;

    @OneToMany(mappedBy = "wall")
    @JsonManagedReference
    private List<Route> routes;


    @PrePersist
    private void prePersist() {
        this.creationTime = Util.now();
    }


    @Data @NoArgsConstructor @AllArgsConstructor
    public static class PK implements Serializable {
        private Long gymId;
        private Long edgeCode;
        private OffsetDateTime creationTime;
    }
}
