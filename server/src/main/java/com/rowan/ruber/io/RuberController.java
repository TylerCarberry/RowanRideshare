package com.rowan.ruber.io;

import java.time.LocalTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.rowan.ruber.Authenticator;
import com.rowan.ruber.repository.*;
import com.rowan.ruber.model.*;

import com.rowan.ruber.model.google_maps.GeoencodingResult;
import com.rowan.ruber.model.google_maps.Location;
import com.rowan.ruber.repository.AddressRepository;
import com.rowan.ruber.repository.ChatroomRepository;
import com.rowan.ruber.repository.MessageRepository;
import com.rowan.ruber.repository.ProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import com.rowan.ruber.Search;

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

    // Temp
    @GetMapping(path="/profile/all")
    public @ResponseBody Iterable<Profile> getProfiles() {
        return profileRepository.findAll(); //returns JSON or XML of addresses
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
                Date createdDate = new Date(); 
                profile = new Profile(name, email, null, createdDate); //let DB handle date creation
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

    @PostMapping(path="/profile/{profileID}/schedule/new")
    public @ResponseBody Schedule createUpdateSchedule(@PathVariable int profileID, Map<String, String> map) {
        Schedule schedule = null;
        try {
            Profile profile = profileRepository.findById(profileID).get();
            
            //TODO get input from map, parse it
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return schedule;
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

    @Autowired
    private Search search;

    @GetMapping("/matching/{profileID}/{radius}")
    public @ResponseBody List<Profile> getMatches(@PathVariable int profileID, @PathVariable int radius){
        try{
            List<Profile> profiles = search.getMatches(profileRepository, profileID, radius);
            System.out.println("test");
            return profiles;
        }
        catch(IllegalArgumentException e){
            return null;
        }
    }

    // TODO: Remove this endpoint once it is hooked directly into set address since this endpoint won't be needed
    @RequestMapping(path="/maps", method = RequestMethod.GET)
    public Location getCoordinatesFromAddress(@RequestParam String address) {
        // If you are reading this after December 2018, our API key has been deactivated
        String url = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyBUWTvOdjkdIur2IFzkEPCVTodoL7xUzJk&address=" + address;

        RestTemplate restTemplate = new RestTemplate();
        GeoencodingResult geoencodingResult = restTemplate.getForObject(url, GeoencodingResult.class);

        return geoencodingResult.getResults().get(0).getGeometry().getLocation();

    }

    /** TEST BELOW AND THE SCHEDULE ENDPOINT */
    
    /**
     * Return a map of the formmated
     * @param s
     * @return
     */
    private Map<String, LocalTime> extractSchedule(String s) {
        //0600,0630,1700,1730
        s = s.trim();
        Map<String, LocalTime>  map = new HashMap<String, LocalTime>();
        String goingToStart = formatScheduleTime(s.substring(0, 4));
        String goingToEnd = formatScheduleTime(s.substring(4,8));
        String leavingStart = formatScheduleTime(s.substring(8,12));
        String leavingEnd = formatScheduleTime(s.substring(12)); 
        
        map.put("goingToStart", LocalTime.parse(goingToStart));
        map.put("goingToEnd", LocalTime.parse(goingToStart));
        map.put("leavingStart", LocalTime.parse(goingToStart));
        map.put("leavingEnd", LocalTime.parse(goingToStart));
        return map;
    }

    /**
     * Takes input in as HHMM and outputs HH:MM.
     * i.e. 0600 -> 06:00
     * @param s
     * @return
     */
    private String formatScheduleTime(String s) {
        return s.substring(0,2) + ":" + s.substring(2);
    }

}