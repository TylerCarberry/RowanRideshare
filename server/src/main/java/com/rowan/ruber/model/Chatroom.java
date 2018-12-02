package com.rowan.ruber.model;

import javax.persistence.Transient;
import javax.persistence.PostLoad;
import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

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
    private List<Message> messages = new ArrayList<Message>();

    @Transient
    private HashMap<String, String> emails = new HashMap<String, String>(); // use this instead of profiles to stop infinite recursion

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

    /**
     * Sets the last message.
     */
    public void setLastMessage(Message message) {
        lastMessage = message;
    }

    @PostLoad
    public void populateEmails() {
        for(int i = 1; i <= profiles.size(); i++) {
            emails.put("Profile " + i, profiles.get(i - 1).getEmail());
        }
    }

}