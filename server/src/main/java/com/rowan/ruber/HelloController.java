package com.rowan.ruber;

import org.springframework.web.bind.annotation.*;

@RequestMapping("/hello")
@RestController
public class HelloController {

    @GetMapping("/greeting")
    public String index(@RequestParam(name="name", required=false, defaultValue="World") String name) {
        return "Hello, " + name + "!";
    }
}