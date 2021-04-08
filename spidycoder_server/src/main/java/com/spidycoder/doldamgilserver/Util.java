package com.spidycoder.doldamgilserver;

import java.time.Clock;
import java.time.OffsetDateTime;
import java.time.temporal.ChronoUnit;

public class Util {
    public static OffsetDateTime now() {
        return OffsetDateTime.now(Clock.systemUTC()).truncatedTo(ChronoUnit.SECONDS);
    }
}
