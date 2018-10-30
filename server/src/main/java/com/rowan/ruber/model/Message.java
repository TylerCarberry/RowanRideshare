package com.rowan.ruber.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;



/** Class to set up the JPA Entity for the Message table in the DB. */
@Entity
@Table(name="message")
public class Message implements Serializable{
    @Id
    @Column(name="MessageID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)   //Identity strategy for MySQL is auto increment
    private int id;

    // TODO: link
    @Column(name="profileGroup")
    private int roomID;

    // TODO: link
    @Column(name="senderID") // links to sender's ProfileID
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

    public Message(int roomID, int senderID, String text, Date timeSent){
        this.roomID = roomID;
        this.senderID = senderID;
        this.text = text;
        this.timeSent = timeSent;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @return the roomID
     */
    public int getRoomID() {
        return roomID;
    }

    /**
     * @return the senderID
     */
    public int getSenderID() {
        return senderID;
    }

    /**
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * @return the timeSent
     */
    public Date getTimeSent() {
        return timeSent;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @param roomID the roomID to set
     */
    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    /**
     * @param senderID the senderID to set
     */
    public void setSenderID(int senderID) {
        this.senderID = senderID;
    }

    /**
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }

    /**
     * @param timeSent the timeSent to set
     */
    public void setTimeSent(Date timeSent) {
        this.timeSent = timeSent;
    }

}