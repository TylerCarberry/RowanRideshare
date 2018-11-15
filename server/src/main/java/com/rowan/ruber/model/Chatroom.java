package com.rowan.ruber.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import java.util.Date;
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


    /** 
     *  Default constructor for JPA. 
     *  It should not be used directly as no values will be initialized.
     */
    public Chatroom(){}

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
     * Gets the created date of this chat room
     * @return the createdDate
     */
    public Date getCreatedDate() {
        return createdDate;
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
     * Sets the last message.
     */
    public void setLastMessage(Message message) {
        lastMessage = message;
    }

}