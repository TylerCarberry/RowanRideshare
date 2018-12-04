package com.rowan.ruber.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

@Entity
@Table(name="chatroom")
public class Chatroom implements Serializable{
    @Id
    @Column(name="ChatroomID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)   //Identity strategy for MySQL is auto increment
    private int chatRoomId;

    @Column(name="CreatedDate")
    private Date createdDate;

    @OneToOne
    @JoinColumn(name="LastMessageID")
    private Message lastMessage;

    @JsonBackReference
    @ManyToMany(mappedBy="chatrooms")
    private List<Profile> profiles = new ArrayList<Profile>(); 

    @JsonManagedReference
    @OneToMany(mappedBy = "chatroom", cascade=CascadeType.REMOVE)
    @OrderBy("timeSent asc ")
    private List<Message> messages = new ArrayList<Message>();

    @Transient
    private HashMap<String, String> emails = new HashMap<String, String>(); // use this instead of profiles to stop infinite recursion

    @Transient
    private HashMap<String, Integer> profileIDs = new HashMap<String, Integer>();

    @Transient
    private HashMap<String, String> profileNames = new HashMap<String, String>();

    /** 
     *  Default constructor for JPA. 
     *  It should not be used directly as no values will be initialized.
     */
    public Chatroom(){
    }

    /**
     * When chat room is first created, there can't be a message sent yet.
     * A message has to belong to a chatroom, so lastMessage is initially null.
     * 
     * LastMessageId is nullable on database
     * @param createdDate
     */
    public Chatroom(Date createdDate){
        this.createdDate = createdDate;
        lastMessage = null;
    }

    /**
     * Gets the chat room id
     * @return the chatRoomId
     */
    public int getChatRoomId() {
        return chatRoomId;
    }

    /**
     * Get the formatted date and time this profile was created.
     * Avoid using SimpleDateFormat as it is not thread-safe.
     * @return the createdDate as a formatted String.
     */
    public String getCreatedDate() {
        return String.format("%1$TD %1$TT", createdDate);
    }

    /**
     * Gets the very recent message id
     * @return the lastMessageId
     */
    public Message getLastMessageId() {
        return lastMessage;
    }

    /**
     * Gets the messages for this chatroom.
     * @return a list of messages
     */
    public List<Message> getMessages() {
        Collections.sort(messages);
        return messages;
    }

    /**
     * Gets the profiles in this chatroom.
     * @return a list of profiles
     */
    public List<Profile> getProfiles() {
        return profiles;
    }

    /**
     * Gets the profileIDs in this chatroom.
     * @return a list of profileID
     */
    public HashMap<String, String> getEmails() {
        return emails;
    }

    public HashMap<String, String> getProfileNames() {
        return profileNames;
    }

    public HashMap<String, Integer> getProfileIDs() {
        return profileIDs;
    }

    /**
     * Sets the last message.
     */
    public void setLastMessage(Message message) {
        lastMessage = message;
    }

    @PostLoad
    public void populateTransient() {
        for(int i = 0; i < profiles.size(); i++) {
            Profile p = profiles.get(i);
            String current = Integer.toString(i + 1);
            emails.put("Profile " + current, p.getEmail());
            profileNames.put("Profile " + current , p.getName());
            profileIDs.put("Profile " + current, p.getId());
        }


    }


    

}