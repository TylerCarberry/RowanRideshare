package com.rowan.ruber.io;

import java.util.List;
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

    /**
     * Get the chatroom. 
     * @param chatroomID the ID for the chatroom
     * @return the profile in JSON format
     */
    @RequestMapping(path="/chatroom/{chatroomID}", method = RequestMethod.GET)
    public @ResponseBody Optional<Chatroom> getChatroom(@PathVariable int chatroomID) {
        return chatroomRepository.findById(chatroomID);
    }

    @RequestMapping(path="/address/{profileID}", method = RequestMethod.GET)
    public @ResponseBody Optional<Address> getAddress(@PathVariable int profileID){
        // Optional<>.get() returns the Profile object if it was obtained.
        Profile profile = getProfile(profileID).get(); 
        // If Profile.Address is not nullable, Optional.of() is a better option.
        return Optional.ofNullable(profile.getAddress());
    }

    @RequestMapping(path="/messages/{chatroomID}", method = RequestMethod.GET)
    public @ResponseBody Optional<List<Message>> getMessage(@PathVariable int chatroomID) {
        Chatroom chatroom = getChatroom(chatroomID).get();
        return Optional.ofNullable(chatroom.getMessages());
    }
}