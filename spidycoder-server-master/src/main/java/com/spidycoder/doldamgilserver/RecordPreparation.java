package com.spidycoder.doldamgilserver;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.OffsetDateTime;

@Getter @AllArgsConstructor
public class RecordPreparation {
    private final Long gymId;

    private final Long edgeCode;

    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private final OffsetDateTime wallCreationTime;

    private final Long creatorId;

    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private final OffsetDateTime routeCreationTime;

    private final Long climberId;
}
