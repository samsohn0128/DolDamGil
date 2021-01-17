package com.spidycoder.doldamgilserver;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
@AllArgsConstructor(onConstructor_ = @Autowired) // onConstructor = @__(@Autowired)
public class UserController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    @GetMapping
    public List<User> retrieveAllUsers() {
        return userRepository.findAll();
    }


    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public void createUser(@RequestBody User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
    }


    @GetMapping("/{id}")
    public User retrieveUserById(@PathVariable Long id) {
        return userRepository.findById(id)
                .orElseThrow(UserNotFoundException::new);
    }


    @GetMapping("/{creatorId}/routes")
    public List<Route> retrieveAllRoutesByCreatorId(@PathVariable Long creatorId) {
        return retrieveUserById(creatorId).getRoutes();
    }


    @GetMapping("/{climberId}/records")
    public List<Record> retrieveAllRecordsByClimberId(@PathVariable Long climberId) {
        return retrieveUserById(climberId).getRecords();
    }
}
