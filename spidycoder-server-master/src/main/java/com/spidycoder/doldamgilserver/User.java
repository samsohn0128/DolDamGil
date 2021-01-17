package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.List;

@Data
@Entity(name = "user")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Email
    @Column(nullable = false)
    private String email;

    @NotNull
    @Size(min = 12)
    @Column(nullable = false)
    private String password;

    private String nickname;

    private String experience;

    private LocalDate birthday;

    private Integer height;

    private Integer weight;

    @OneToMany(mappedBy = "climber")
    @JsonManagedReference("user-to-record")
    private List<Record> records;


    @OneToMany(mappedBy = "creator")
    @JsonManagedReference("user-to-route")
    private List<Route> routes;
}
