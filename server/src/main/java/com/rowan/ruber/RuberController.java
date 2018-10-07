package com.rowan.ruber;

import org.springframework.web.bind.annotation.*;

@RequestMapping("/rides")
@RestController
public class RuberController {

    @GetMapping("/nearby")
    public String index(@RequestParam(name="authToken") String authToken) {
        return "Hello from RUber!";
    }
}