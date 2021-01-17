package com.spidycoder.doldamgilserver;

import org.springframework.data.jpa.repository.JpaRepository;

public interface RecordRepository extends JpaRepository<Record, Record.PK> {
}
