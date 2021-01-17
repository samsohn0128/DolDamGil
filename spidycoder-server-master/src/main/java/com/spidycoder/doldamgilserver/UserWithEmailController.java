package com.spidycoder.doldamgilserver;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user-with-email={email}")
@AllArgsConstructor(onConstructor_ = @Autowired) // onConstructor = @__(@Autowired)
public class UserWithEmailController {
    private final UserRepository userRepository;


    @GetMapping
    public User retrieveUserByEmail(@PathVariable String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(UserNotFoundException::new);
    }
}
