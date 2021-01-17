package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.OffsetDateTime;

@Data
@Entity(name = "record")
@IdClass(Record.PK.class)
public class Record {
    @Id @Column(name = "climber_id")
    private Long climberId;

    @Id @Column(name = "record_time", columnDefinition = "default current_timestamp()")
    private OffsetDateTime recordTime;

    @ManyToOne
    @JoinColumn(name = "climber_id", referencedColumnName = "id", insertable = false, updatable = false)
    @JsonBackReference("user-to-record")
    private User climber;

    @ManyToOne
    @JoinColumn(name = "gym_id", referencedColumnName = "gym_id")
    @JoinColumn(name = "edge_code", referencedColumnName = "edge_code")
    @JoinColumn(name = "wall_creation_time", referencedColumnName = "wall_creation_time")
    @JoinColumn(name = "creator_id", referencedColumnName = "creator_id")
    @JoinColumn(name = "route_creation_time", referencedColumnName = "creation_time")
    @JsonBackReference
    private Route route;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, columnDefinition = "enum ('SUCCESS', 'FAIL') default 'FAIL'")
    private Result result = Result.FAIL;

    private Integer difficulty;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "enum ('SOSO', 'GOOD', 'BEST')")
    private Satisfaction satisfaction;


    @PrePersist
    private void prePersist() {
        this.recordTime = Util.now();
    }


    @Data @NoArgsConstructor @AllArgsConstructor
    public static class PK implements Serializable {
        private Long climberId;
        private OffsetDateTime recordTime;
    }


    @SuppressWarnings("unused")
    public enum Result {
        SUCCESS, FAIL
    }


    @SuppressWarnings("unused")
    public enum Satisfaction {
        SOSO, GOOD, BEST
    }
}
