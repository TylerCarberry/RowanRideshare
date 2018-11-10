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

    @Autowired
    private MessageRepository messageRepository;

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
    @GetMapping(path="/profile/{profileID}")
    public @ResponseBody Optional<Profile> getProfile(@PathVariable int profileID) {
        return profileRepository.findById(profileID);
    }

    /**
     * Get the chatroom. 
     * @param chatroomID the ID for the chatroom
     * @return the profile in JSON format
     */
    @GetMapping(path="/chatroom/{chatroomID}")
    public @ResponseBody Optional<Chatroom> getChatroom(@PathVariable int chatroomID) {
        return chatroomRepository.findById(chatroomID);
    }

    @GetMapping(path="/address/{profileID}")
    public @ResponseBody Optional<Address> getAddress(@PathVariable int profileID){
        // Optional<>.get() returns the Profile object if it was obtained.
        Profile profile = getProfile(profileID).get(); 
        // If Profile.Address is not nullable, Optional.of() is a better option.
        return Optional.ofNullable(profile.getAddress());
    }

    @GetMapping(path="/messages/{chatroomID}")
    public @ResponseBody Optional<List<Message>> getMessage(@PathVariable int chatroomID) {
        Chatroom chatroom = getChatroom(chatroomID).get();
        return Optional.ofNullable(chatroom.getMessages());
    }

    @GetMapping(path="/schedule/{profileID}")
    public @ResponseBody Optional<List<Schedule>> geStSchedule(@PathVariable int profileID){
        Profile profile = getProfile(profileID).get();
        return Optional.ofNullable(profile.getSchedules());
    }

    // TODO: finish post
    @PostMapping(path="/profile/new")
    public @ResponseBody Profile createUpdateProfile(@RequestBody Profile profile){
        //addressRepository.save(profile.getAddress()); //in case we want to update the whole profile object
        return profileRepository.save(profile);
    }

    @PostMapping(path="/address/new")
    public @ResponseBody Address createUpdateAddress(@RequestBody Address address) {
        return addressRepository.save(address);
    } 

    @PostMapping(path="/chatroom/new")
    public @ResponseBody Chatroom createUpdateChatroom(@RequestBody Chatroom chatroom) {
        return chatroomRepository.save(chatroom);
    }

    @PostMapping(path="/message/new")
    public @ResponseBody Message createMessage(@RequestBody Message message) {
        return messageRepository.save(message);
    }
    
}