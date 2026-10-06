package com.example.studentrecords.controller;

import com.example.studentrecords.dto.LoginRequest;
import com.example.studentrecords.dto.RegisterRequest;
import com.example.studentrecords.entity.User;
import com.example.studentrecords.repository.UserRepository;
import com.example.studentrecords.security.JwtUtil;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {
    private final UserRepository users;
    private final PasswordEncoder encoder;
    private final AuthenticationManager manager;
    private final JwtUtil jwt;

    public AuthController(UserRepository users,
                          PasswordEncoder encoder,
                          AuthenticationManager manager,
                          JwtUtil jwt) {
        this.users = users;
        this.encoder = encoder;
        this.manager = manager;
        this.jwt = jwt;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterRequest r) {
        if (users.findByUsername(r.getUsername()).isPresent()) {
            return ResponseEntity.badRequest()
                    .body(Map.of("error", "username already taken"));
        }

        User u = new User();
        u.setUsername(r.getUsername());
        u.setPassword(encoder.encode(r.getPassword()));
        users.save(u);

        return ResponseEntity.status(201)
                .body(Map.of("message", "registered successfully"));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest r) {
        manager.authenticate(
                new UsernamePasswordAuthenticationToken(r.getUsername(), r.getPassword()));
        return ResponseEntity.ok(Map.of("token", jwt.generateToken(r.getUsername())));
    }
}
