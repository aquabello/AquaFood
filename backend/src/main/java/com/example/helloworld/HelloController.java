package com.example.helloworld;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Collections;
import java.util.Map;

@RestController
public class HelloController {

    @Value("${server.name:default-server}") // Default value if env var is not set
    private String serverName;

    @GetMapping("/api/hello")
    public Map<String, String> hello() {
        String message = "Hello from " + serverName;
        return Collections.singletonMap("message", message);
    }
}
