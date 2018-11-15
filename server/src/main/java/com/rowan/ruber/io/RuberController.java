package com.rowan.ruber.io;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.rowan.ruber.Authenticator;
import com.rowan.ruber.repository.*;
import com.rowan.ruber.model.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
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
    public @ResponseBody Optional<List<Schedule>> getSchedule(@PathVariable int profileID){
        Profile profile = getProfile(profileID).get();
        return Optional.ofNullable(profile.getSchedules());
    }

    @PostMapping(path={"/profile/new", "/profile/update"})
    public @ResponseBody Profile createUpdateProfile(@RequestBody Map<String, String> map){
        Profile profile = null;
        try {
            String name = map.get("name");
            String email = map.get("email");

            //if id exists, then we are doing an update. Otherwise, new profile
            if(map.containsKey("id")) {
                int profileID = Integer.parseInt(map.get("id"));
                profile = profileRepository.findById(profileID).get();

                profile.setName(name);
                profile.setEmail(email);
            }
            else {
                int addressID = Integer.parseInt(map.get("address"));
                Date createdDate = new Date(); 
                Address address = addressRepository.findById(addressID).get();
                
                /**
                 * May want to convert to this soon
                String streetAddress = map.get("address");
                String city = map.get("city");
                String state = map.get("state");
                String zipCode = map.get("zipCode");
                //Get the lat long 
                Address address = new Address(streetAddress, city, state, zipCode, latitude, longitude)
                createUpdateAddress(Address);
                */
                
                profile = new Profile(name, email, address, createdDate); //let DB handle date creation
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return profileRepository.save(profile);
    }

    @PostMapping(path={"/address/new", "/address/update"})
    public @ResponseBody Address createUpdateAddress(@RequestBody Address address) {
        return addressRepository.save(address);
    }

    /** 
     * I decided to combine create chatroom and addProfileToChatroom.
     * Since we're manually taking care of createDate, a chatroom should consist of at least 1 user to start the chatroom
     * otherwise a chatroom is just hanging around not attached to any profiles.
     */
    @PostMapping(path="/profile/{profileID}/chatroom/new")
    public @ResponseBody Profile addProfileToChatroom(@PathVariable int profileID, @RequestBody Map<String,String> map) {
        Profile profile = null;
        try {
            profile = profileRepository.findById(profileID).get();
            //if chatroom included not included in map, make new chatroom. Otherwise fetch from DB.
            Chatroom chat = (map.get("chatroom") == null ? chatroomRepository.save(new Chatroom(new Date())):
                            chatroomRepository.findById(Integer.parseInt(map.get("chatroom"))).get());

            profile.getChatrooms().add(chat);
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return profileRepository.save(profile);
    }

    @PostMapping(path="/message/new")
    public @ResponseBody Message createMessage(@RequestBody Map<String, String> map) {
        try{
            int chatroomID = Integer.parseInt(map.get("chatroom"));
            int senderID = Integer.parseInt(map.get("sender"));
            String text = map.get("text");
            Date timeSent = new Date();
            Chatroom chatroom = chatroomRepository.findById(chatroomID).get();
            Message message = new Message(chatroom, senderID, text, timeSent);
            chatroom.setLastMessage(message);
            return messageRepository.save(message);
        }
        catch(Exception e) {
            e.printStackTrace();
        } 
        return null; //stub for now - try to fix later
    }

    /**
     *  Using try catch for testing phase, in a complete system the app shouldn't attempt to 
     *  delete using a non-existing id.( boolean -> void, and remove try catch.)
     * @param profileID
     * @return false if given id doesn't exist
     */
    @GetMapping("/profile/delete/{profileID}")
    public boolean deleteProfile(@PathVariable int profileID){
        try{
            profileRepository.deleteById(profileID);
            return true;
        }
        catch(IllegalArgumentException e){
            return false;
        }
    }
    
    @GetMapping("/chatroom/delete/{chatroomID}")
    public boolean deleteChatroom(@PathVariable int chatroomID){
        try{
            chatroomRepository.deleteById(chatroomID);
            return true;
        }
        catch(IllegalArgumentException e){
            return false;
        }
    }

    @GetMapping("/message/delete/{messageID}/")
    public boolean deleteMessage(@PathVariable int messageID){
        try{
            messageRepository.deleteById(messageID);
            return true;
        }
        catch(IllegalArgumentException e){
            return false;
        }
    }

}