package com.rowan.ruber.io;

import com.rowan.ruber.Authenticator;
import com.rowan.ruber.repository.AddressRepository;
import com.rowan.ruber.model.Address;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/rides")
@RestController
public class RuberController {

    @Autowired
    private AddressRepository addressRepository;

    @GetMapping("/nearby")
    public String index(@RequestParam(name="authToken") String authToken) {
        Authenticator authenticator = new Authenticator();
        String name = authenticator.authenticate(authToken);

        return "Hello " + name;
    }

    @GetMapping(path="/address/all")
    public @ResponseBody Iterable<Address> getAddresses() {
        return addressRepository.findAll(); //returns JSON or XML of addresses
    }
}