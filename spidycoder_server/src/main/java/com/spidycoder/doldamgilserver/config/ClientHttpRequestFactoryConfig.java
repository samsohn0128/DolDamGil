package com.spidycoder.doldamgilserver.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;

@Configuration
public class ClientHttpRequestFactoryConfig {
    @Bean
    public ClientHttpRequestFactory newHttpComponentsClientHttpRequestFactory() {
        return new HttpComponentsClientHttpRequestFactory();
    }
}
