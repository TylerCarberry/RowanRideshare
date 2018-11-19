package com.rowan.ruber.io;

import com.rowan.ruber.Authenticator;
import com.rowan.ruber.MapsManager;
import com.rowan.ruber.Search;
import com.rowan.ruber.model.*;
import com.rowan.ruber.model.google_maps.GeoencodingResult;
import com.rowan.ruber.model.google_maps.Location;
import com.rowan.ruber.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.time.LocalTime;
import java.util.*;

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

    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private Search search;

    @GetMapping("/nearby")
    public String index(@RequestParam(name = "authToken") String authToken) {
        Authenticator authenticator = new Authenticator();
        String name = authenticator.authenticate(authToken);

        return "Hello " + name;
    }

    @GetMapping(path = "/address/all")
    public @ResponseBody
    Iterable<Address> getAddresses() {
        return addressRepository.findAll(); //returns JSON or XML of addresses
    }

    // Temp
    @GetMapping(path = "/profile/all")
    public @ResponseBody
    Iterable<Profile> getProfiles() {
        return profileRepository.findAll(); //returns JSON or XML of addresses
    }

    /**
     * Get the profile. May return null.
     *
     * @param profileID the ID for the profile.
     * @return the profile in JSON format.
     */
    @GetMapping(path = "/profile/{profileID}")
    public @ResponseBody
    Optional<Profile> getProfile(@PathVariable int profileID) {
        return profileRepository.findById(profileID);
    }

    @GetMapping(path = "/profile/email/{emailAddress}")
    public @ResponseBody
    Optional<Profile> getProfile(@PathVariable String emailAddress){
        return profileRepository.findByEmailAddress(emailAddress);
    }

    /**
     * Get the chatroom.
     *
     * @param chatroomID the ID for the chatroom
     * @return the profile in JSON format
     */
    @GetMapping(path = "/chatroom/{chatroomID}")
    public @ResponseBody
    Optional<Chatroom> getChatroom(@PathVariable int chatroomID) {
        return chatroomRepository.findById(chatroomID);
    }

    @GetMapping(path = "/address/{profileID}")
    public @ResponseBody
    Optional<Address> getAddress(@PathVariable int profileID) {
        // Optional<>.get() returns the Profile object if it was obtained.
        Profile profile = getProfile(profileID).get();
        return Optional.ofNullable(profile.getAddress());
    }

    @GetMapping(path = "/messages/{chatroomID}")
    public @ResponseBody
    Optional<List<Message>> getMessage(@PathVariable int chatroomID) {
        Chatroom chatroom = getChatroom(chatroomID).get();
        return Optional.ofNullable(chatroom.getMessages());
    }

    @GetMapping(path = "/schedule/{profileID}")
    public @ResponseBody
    Optional<List<Schedule>> getSchedule(@PathVariable int profileID) {
        Profile profile = getProfile(profileID).get();
        return Optional.ofNullable(profile.getSchedules());
    }

    @PostMapping(path = {"/profile/new", "/profile/update"})
    public @ResponseBody
    Profile createUpdateProfile(@RequestBody Map<String, String> map) {
        Profile profile = null;
        try {
            String name = map.get("name");
            String email = map.get("email");

            //if id exists, then we are doing an update. Otherwise, new profile
            if (map.containsKey("id")) {
                int profileID = Integer.parseInt(map.get("id"));
                profile = profileRepository.findById(profileID).get();

                profile.setName(name);
                profile.setEmail(email);
            } else {
                Date createdDate = new Date();
                profile = new Profile(name, email, null, createdDate); //let DB handle date creation
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profileRepository.save(profile);
    }

    @PostMapping(path = {"/address/new", "/address/update"})
    public @ResponseBody
    Address createUpdateAddress(@RequestBody Address address) {
        String formattedAddress = address.getStreetAddress() + " " + address.getCity() + " " + address.getState() + " " + address.getZipCode();
        Location coordinates = MapsManager.getCoordinatesFromAddress(formattedAddress);
        address.setLatitude(coordinates.getLat());
        address.setLongitude(coordinates.getLng());

        return addressRepository.save(address);
    }

    /* TODO - currently no other way to link an address to a profile - need the ProfileID from the front end */
    @PostMapping(path = { "/profile/{profileID}/linkAddress"})
    public @ResponseBody
    Profile linkAddress(@PathVariable int profileID, @PathVariable int addressID) {
        Profile profile = profileRepository.findById(profileID).get();
        Address address = addressRepository.findById(profileID).get();
        profile.setAddress(address);
        return profileRepository.save(profile);
    }

    @PostMapping(path = {"/address/{profileID}/new"})
    public @ResponseBody
    Address createAddress(@RequestBody Address address, @PathVariable int profileID) {
        String formattedAddress = address.getStreetAddress() + " " + address.getCity() + " " + address.getState() + " " + address.getZipCode();
        Location coordinates = MapsManager.getCoordinatesFromAddress(formattedAddress);
        address.setLatitude(coordinates.getLat());
        address.setLongitude(coordinates.getLng());
        Profile profile = profileRepository.findById(profileID).get();
        address = addressRepository.save(address);
        profile.setAddress(address);
        profileRepository.save(profile);
        return address;
    }

    /**
     * I decided to combine create chatroom and addProfileToChatroom.
     * Since we're manually taking care of createDate, a chatroom should consist of at least 1 user to start the chatroom
     * otherwise a chatroom is just hanging around not attached to any profiles.
     */
        @PostMapping(path = {"/profile/{profileID}/chatroom/new", "/profile/{profileID}/chatroom/update"})
    public @ResponseBody
    Profile addProfileToChatroom(@PathVariable int profileID, @RequestBody Map<String, String> map) {
        Profile profile = null;
        try {
            profile = profileRepository.findById(profileID).get();
            //if chatroom included not included in map, make new chatroom. Otherwise fetch from DB.
            String chatroomID = map.get("chatroomID");
            Chatroom chat = (chatroomID == null ? chatroomRepository.save(new Chatroom(new Date())) :
                    chatroomRepository.findById(Integer.parseInt(chatroomID)).get());

            profile.getChatrooms().add(chat);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profileRepository.save(profile);
    }

    @PostMapping(path = "/message/new")
    public @ResponseBody
    Message createMessage(@RequestBody Map<String, String> map) {
        Message message = null;
        try {
            int chatroomID = Integer.parseInt(map.get("chatroomID"));
            int senderID = Integer.parseInt(map.get("senderID"));

            Profile sender = profileRepository.findById(senderID).get();
            Chatroom chatroom = chatroomRepository.findById(chatroomID).get();

            //Checking the list in chatroom is better than checking sender b/c chatrooms have limited number of profiles
            if(! chatroom.getProfiles().contains(sender))
                throw new Exception("This profile is not in this chatroom");

            String text = map.get("text");
            Date timeSent = new Date();
            message = new Message(chatroom, senderID, text, timeSent);
            chatroom.setLastMessage(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messageRepository.save(message);
    }

    /** 
     * If attempt to create a schedule failed - i.e. there's a dupe, then scheduleID will still autoincrement  
     * 
     * If trying to create an already made schedule (i.e. "MONDAY" : "0600...") already exists, it will throw exception and stop
     * even if there are other days that have not been made -> for example if "TUESDAY" :"0700..." has not been made
     * but comes after "MONDAY" in the map.
     * 
     * //TODO FIX ABOVE 
     * //
     */
    @PostMapping(path = "/profile/{profileID}/schedule/new")
    public @ResponseBody 
    List<Schedule> createSchedule(@PathVariable int profileID, @RequestBody Map<String, String> map) {
        List<Schedule> schedules = new LinkedList<Schedule>();
        try {
            Profile profile = profileRepository.findById(profileID).get();

            for(Day day : Day.values()) {
                 //get "monday", "tuesday", etc. from map and convert to Schedule
                String dayString = day.toString().trim().toLowerCase();
                if(map.get(dayString) != null) {
                    Schedule daySchedule = extractSchedule(day, profile, map.get(dayString));
                    schedules.add(daySchedule);
                    scheduleRepository.save(daySchedule); // commit to db
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return schedules;
    }

    /**
     * For some reason when there are new schedules in the map, the getSchedule response doesn't immediately reflect those,
     * therefore another list is hold the schedules.
     */
    @PostMapping(path = "/profile/{profileID}/schedule/update")
    public @ResponseBody 
    List<Schedule> updateSchedule(@PathVariable int profileID, @RequestBody Map<String, String> map) {
        List<Schedule> schedules = new LinkedList<Schedule>();
        try {
            Profile profile = profileRepository.findById(profileID).get();

            /* Getting null pointer somewhere */
            //update existing schedules and remove from map once processed
            for(Schedule schedule : profile.getSchedules()) {
                Day day = schedule.getDay();
                String dayString = day.toString().trim().toLowerCase();
                String scheduleString = map.get(dayString);
                Schedule temp = extractSchedule(day, profile, scheduleString); //technically don't need new object

                schedule.setGoingToStart(temp.getGoingToStart());
                schedule.setGoingToEnd(temp.getGoingToEnd());
                schedule.setLeavingStart(temp.getLeavingStart());
                schedule.setLeavingEnd(temp.getLeavingEnd());
                scheduleRepository.save(schedule);

                map.remove(dayString);
                schedules.add(schedule);
            }

            //The remaining ones are new schedules
            for(Schedule newSchedule : createSchedule(profileID, map)) {
                schedules.add(newSchedule);
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return schedules; 
    }


    /**
     * Using try catch for testing phase, in a complete system the app shouldn't attempt to
     * delete using a non-existing id.( boolean -> void, and remove try catch.)
     *
     * @param profileID
     * @return false if given id doesn't exist
     */
    @GetMapping("/profile/delete/{profileID}")
    public boolean deleteProfile(@PathVariable int profileID) {
        try {
            profileRepository.deleteById(profileID);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    @GetMapping("/chatroom/delete/{chatroomID}")
    public boolean deleteChatroom(@PathVariable int chatroomID) {
        try {
            chatroomRepository.deleteById(chatroomID);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    @GetMapping("/message/delete/{messageID}/")
    public boolean deleteMessage(@PathVariable int messageID) {
        try {
            messageRepository.deleteById(messageID);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    @GetMapping("/matching/{profileID}/{radius}")
    public @ResponseBody
    List<Profile> getMatches(@PathVariable int profileID, @PathVariable int radius) {
        try {
            List<Profile> profiles = search.getMatches(profileRepository, profileID, radius);
            return profiles;
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    // TODO: Remove this endpoint once it is hooked directly into set address since this endpoint won't be needed
    @RequestMapping(path = "/maps", method = RequestMethod.GET)
    public Location getCoordinatesFromAddress(@RequestParam String address) {
        // If you are reading this after December 2018, our API key has been deactivated :)
        String url = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyBUWTvOdjkdIur2IFzkEPCVTodoL7xUzJk&address=" + address;

        RestTemplate restTemplate = new RestTemplate();
        GeoencodingResult geoencodingResult = restTemplate.getForObject(url, GeoencodingResult.class);

        return geoencodingResult.getResults().get(0).getGeometry().getLocation();

    }


    /**
     * Return a Schedule representing the given day and the schedule string
     * Does not check if the given string is numeric.
     * 
     * @param s Schedule string of the form "0060..." - every 4 characters represents a time
     * @return a Schedule
     */
    private Schedule extractSchedule(Day day, Profile profile, String s) {
        //0600063017001730 -> 06:00, 06:30, 17:00, 17:30
        s = s.trim();
        String goingToStart = formatScheduleTime(s.substring(0, 4));
        String goingToEnd = formatScheduleTime(s.substring(4, 8));
        String leavingStart = formatScheduleTime(s.substring(8, 12));
        String leavingEnd = formatScheduleTime(s.substring(12));

        return new Schedule(profile, day, LocalTime.parse(goingToStart), 
                LocalTime.parse(goingToEnd), LocalTime.parse(leavingStart), LocalTime.parse(leavingEnd));
    }

    /**
     * Takes input string in as HHMM and outputs HH:MM.
     * i.e. 0600 -> 06:00
     *
     * @param s Input string "HHMM"
     * @return Formatted string "HH:MM"
     */
    private String formatScheduleTime(String s) {
        return s.substring(0, 2) + ":" + s.substring(2);
    }
}