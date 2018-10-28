package com.rowan.ruber.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;

@Entity
@Table(name="chatroom")
public class Chatroom implements Serializable{
    @Id
    @Column(name="ChatroomID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)   //Identity strategy for MySQL is auto increment
    private int chatRoomId;

    @Column(name="CreatedDate")
    private Date createdDate;

    // TODO: linking
    // wrapper type Int because it is nullable on the database
    @Column(name="LastMessageID")
    private Integer lastMessageId;

    /** 
     *  Default constructor for JPA. 
     *  It should not be used directly as no values will be initialized.
     */
    public Chatroom(){}

    /**
     * When chat room is first created, there may not be a message sent yet.
     * LastMessageId is nullable on database
     * @param createdDate
     */
    public Chatroom(Date createdDate){
        this.createdDate = createdDate;
    }

    public Chatroom(Date createdDate, int lastMessageId){
        this.createdDate = createdDate;
        this.lastMessageId = lastMessageId;
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
    public int getLastMessageId() {
        return lastMessageId;
    }
}