package com.spidycoder.doldamgilserver.config;

import com.spidycoder.doldamgilserver.UserPrincipalDetailsService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;


@Configuration
@EnableWebSecurity
@RequiredArgsConstructor(onConstructor_ = @Autowired)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserPrincipalDetailsService userPrincipalDetailsService;
    private final PasswordEncoder passwordEncoder;


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf()
                        .ignoringAntMatchers("/users/**")
                        .ignoringAntMatchers("/gyms/**")
                .and().authorizeRequests()
                        .antMatchers(HttpMethod.POST, "/users").permitAll()
                        .antMatchers(HttpMethod.PATCH, "/gyms/*/edges/*").permitAll()
                        .antMatchers(HttpMethod.POST, "/gyms/*/edges/*/walls").permitAll()
                        .antMatchers(HttpMethod.POST, "/gyms/*/edges/*/walls/*/routes/*/*/records").permitAll()
                        .anyRequest().authenticated()
                .and().formLogin()
                .and().httpBasic();
    }


    @Override
    protected void configure(AuthenticationManagerBuilder auth) {
        final var daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder);
        daoAuthenticationProvider.setUserDetailsService(userPrincipalDetailsService);
        auth.authenticationProvider(daoAuthenticationProvider);
    }
}
