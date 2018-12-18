package com.rowan.ruber.io;

import org.springframework.web.bind.annotation.*;

/**
 * A test controller to make sure the server is running
 */
@RequestMapping("/hello")
@RestController
public class HelloController {

    @GetMapping("/greeting")
    public String index(@RequestParam(name="name", required=false, defaultValue="World") String name) {
        return "Hello, " + name + "!";
    }
}