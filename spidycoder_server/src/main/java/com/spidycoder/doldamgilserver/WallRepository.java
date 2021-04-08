package com.spidycoder.doldamgilserver;

import org.springframework.data.jpa.repository.JpaRepository;

public interface WallRepository extends JpaRepository<Wall, Wall.PK> {
}
