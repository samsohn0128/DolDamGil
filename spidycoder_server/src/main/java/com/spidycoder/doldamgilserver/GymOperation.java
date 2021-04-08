package com.spidycoder.doldamgilserver;

import lombok.Data;

import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
@Entity
@IdClass(GymOperation.PK.class)
public class GymOperation {
    @Id
    private Long operatorId;

    @Id
    private Long gymId;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "enum ('MANAGER', 'OWNER') default 'MANAGER'")
    private Role role = Role.MANAGER;


    public enum Role {
        MANAGER, OWNER
    }


    @Data
    public static class PK implements Serializable {
        private Long operatorId;
        private Long gymId;
    }
}
