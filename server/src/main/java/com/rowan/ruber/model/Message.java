package com.rowan.ruber.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

//import java.sql.Date;
import java.util.Date;



/** Class to set up the JPA Entity for the Message table in the DB. */
@Entity
@Table(name="message")
public class Message implements Serializable{
    @Id
    @Column(name="MessageID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)   //Identity strategy for MySQL is auto increment
    private int id;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "ChatroomID")
    private Chatroom chatroom;

    @Column(name="senderID")
    private int senderID;

    @Column(name="text")
    private String text;

    @Column(name="timeSent")
    private Date timeSent;

    /** 
     *  Default constructor for JPA. 
     *  It should not be used directly as no values will be initialized.
     */
    public Message(){}

    public Message(Chatroom chatroom, int senderID, String text, Date timeSent){
        this.chatroom = chatroom;
        this.senderID = senderID;
        this.text = text;
        this.timeSent = timeSent; // SQL date or util date?
    }


	/**
     * Get the message id.
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * Get the chatroom.
     * @return the chatroom
     */
    public Chatroom getChatroom() {
        return chatroom;
    }

    /**
     * Get the sender.
     * @return a profile
     */
    public int getSenderID() {
        return senderID;
    }

    /**
     * Get the message text. Limit of 200 characters.
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * Get the formatted date and time this message was sent.
     * Avoid using SimpleDateFormat as it is not thread-safe.
     * @return the timeSent as a formatted String.
     */
    public String getTimeSent() {
        return String.format("%1$TD %1$TT", timeSent);
    }

    /**
     * Set the message id
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Set the chatroom.
     * @param chatroom the chatroom to set
     */
    public void setChatroom(Chatroom chatroom) {
        this.chatroom = chatroom;
    }

    /**
     * Set the sender for this message.
     * @param sender the sender's profile
     */
    public void setSender(int senderID) {
        this.senderID = senderID;
    }

    /**
     * Set the text for this message.
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }

    /**
     * Set the date and time for this message.
     * @param timeSent the timeSent to set
     */
    public void setTimeSent(Date timeSent) {
        this.timeSent = timeSent;
    }

}