package com.rowan.ruber.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.io.Serializable;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;

/**
 * Class to set up the JPA Entity for the Profile table in the database
 */
@Entity
@Table(name = "profile")
public class Profile implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="profileID")
    private int id;

    private String name;

    @Column(name="EmailAddress")
    private String email;

    // Refers to address table
    // ** Leaving out ON UPDATE ON DELETE for now since they are defined in MySQL - will add later if needed.
    @OneToOne(cascade=CascadeType.REMOVE)
    @JoinColumn(name="AddressID")
    private Address address;

    @Column(name="CreatedDate")
    private Date createdDate;

    @JsonManagedReference
    @OneToMany(mappedBy="profile", cascade=CascadeType.REMOVE)
    private List<Schedule> schedules = new ArrayList<Schedule>(); // Maintain bi-directional 1 to Many w/ Schedule

    @ManyToMany
    @JoinTable(name = "chatroomProfile",
            joinColumns = { @JoinColumn(name = "ProfileID") },
            inverseJoinColumns = { @JoinColumn(name = "ChatroomID") })
    private List<Chatroom> chatrooms = new ArrayList<Chatroom>(); //Profile is the "owner" side of the relationship

    /** 
     *  Default constructor for JPA.
     *  It should not be used directly as no values will be initialized.
     */
    public Profile(){
        
    }

    public Profile(String name, String email, Address address, Date createdDate){
        this.name = name;
        this.email = email;
        this.address = address;
        this.createdDate = createdDate;
    }

    /**
     * Returns the string representation for Profile.
     * @return the String representation for a Profile
    */
    public String toString(){
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
        return String.format("Name: %s %n Email: %s %n AddressID: %d %n Created Date: %s %n", 
                            name, email, address.toString(), sdf.format(createdDate));
    }

    /**
     * Gets the profile id.
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * Gets the name.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Gets the email.
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Gets the address.
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * Get the date and time this profile was created.
     * @return the createdDate
     */
    public Date getCreatedDate() {
        return createdDate;
    }

    /**
     * Gets the schedules for a profile.
     * @return a list of schedules
     */
    public List<Schedule> getSchedules() {
        return schedules;
    }

    /**
     * Gets the chatrooms that this profile is in.
     * @return a list of chatrooms 
     */
    public List<Chatroom> getChatrooms() {
        return chatrooms;
    }

    /**
     * Sets the address.
     * @param address the address object to set to
     */
    public void setAddress(Address address) {
        this.address = address;
    }
    
    /**
     * Sets the email. Limit of 45 characters.
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Sets the name. Limit of 90 characters.
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Sets the schedule.
     * @param schedules the schedules to set
     */
    public void setSchedules(List<Schedule> schedules) {
        this.schedules = schedules;
    }
}
