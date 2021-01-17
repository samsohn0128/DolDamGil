package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.List;

@Data
@Entity(name = "route")
@IdClass(Route.PK.class)
public class Route {
    @Id @Column(name = "gym_id", nullable = false)
    private Long gymId;

    @Id @Column(name = "edge_code", nullable = false)
    private Long edgeCode;

    @Id @Column(name = "wall_creation_time", nullable = false)
    private OffsetDateTime wallCreationTime;

    @Id @Column(name = "creator_id", nullable = false)
    private Long creatorId;

    @Id @Column(name = "creation_time", nullable = false, columnDefinition = "default current_timestamp()")
    private OffsetDateTime creationTime;

    @ManyToOne
    @JoinColumn(name = "gym_id", referencedColumnName = "gym_id", insertable = false, updatable = false)
    @JoinColumn(name = "edge_code", referencedColumnName = "edge_code", insertable = false, updatable = false)
    @JoinColumn(name = "wall_creation_time", referencedColumnName = "creation_time", insertable = false, updatable = false)
    @JsonBackReference
    private Wall wall;

    @ManyToOne
    @JoinColumn(name = "creator_id", referencedColumnName = "id", insertable = false, updatable = false)
    @JsonBackReference("user-to-route")
    private User creator;

    private String routeDoc;

    private String difficulty;

    private String title;

    @OneToMany(mappedBy = "route")
    private List<Record> records;


    @PrePersist
    private void prePersist() {
        this.creationTime = Util.now();
    }


    @Data @NoArgsConstructor @AllArgsConstructor
    public static class PK implements Serializable {
        private Long gymId;
        private Long edgeCode;
        private OffsetDateTime wallCreationTime;
        private Long creatorId;
        private OffsetDateTime creationTime;
    }
}
