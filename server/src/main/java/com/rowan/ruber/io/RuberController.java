package com.rowan.ruber.io;

import com.rowan.ruber.Authenticator;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/rides")
@RestController
public class RuberController {

    @GetMapping("/nearby")
    public String index(@RequestParam(name="authToken") String authToken) {
        Authenticator authenticator = new Authenticator();
        String name = authenticator.authenticate(authToken);

        return "Hello " + name;
    }
}