package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;

@Data
@Entity(name = "gym")
public class Gym {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private BigDecimal longitude;

    @NotNull
    @Column(nullable = false)
    private BigDecimal latitude;

    @NotNull
    @Column(nullable = false)
    private String name;

    private String address;

    private String phone;

    private String description;

    @NotNull
    @Column(nullable = false)
    private Boolean closed = false;

    private String currency;

    private Integer shoes;

    private Integer footbath;

    private Integer shower;

    private Integer towel;


    @JsonManagedReference
    @OneToMany(mappedBy = "gym")
    private List<Edge> edges;
}
