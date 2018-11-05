package com.rowan.ruber.io;

import java.util.Optional;

import com.rowan.ruber.Authenticator;
import com.rowan.ruber.repository.*;
import com.rowan.ruber.model.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/rides")
@RestController
public class RuberController {

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private ProfileRepository profileRepository;

    @Autowired
    private ChatroomRepository chatroomRepository;

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

    /**
     * Get the profile. May return null.
     * @param profileID the ID for the profile.
     * @return the profile in JSON format.
     */
    @RequestMapping(path="/profile/{profileID}", method = RequestMethod.GET)
    public @ResponseBody Optional<Profile> getProfile(@PathVariable int profileID) {
        return profileRepository.findById(profileID);
    }

    @RequestMapping(path="/chatroom/{chatroomID}", method = RequestMethod.GET)
    public @ResponseBody Optional<Chatroom> getChatroom(@PathVariable int chatroomID) {
        return chatroomRepository.findById(chatroomID);
    }
}