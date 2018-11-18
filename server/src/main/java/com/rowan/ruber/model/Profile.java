package com.rowan.ruber.model;

import javax.persistence.*;
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

    @OneToMany(mappedBy="profile", cascade=CascadeType.REMOVE)
    private List<Schedule> schedules = new ArrayList<Schedule>(); // Maintain bi-directional 1 to Many w/ Schedule

    @ManyToMany
    @JoinTable(name = "chatroomProfile",
            joinColumns = { @JoinColumn(name = "ProfileID") },
            inverseJoinColumns = { @JoinColumn(name = "ChatroomID") })
    private List<Chatroom> chatrooms = new ArrayList<Chatroom>(); //Profile is the "owner" side of the relationship

    @Transient
    private double distance;

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
     * Constructor used when matching is done.
     * @param name Name of the matched profile
     * @param email Email Address of the matched profile
     * @param address Address of the matched profile
     * @param distance Distance of the matched profile
     */
    public Profile(String name, String email, Address address, double distance){
        this.name = name;
        this.email = email;
        this.address = address;
        this.distance = distance;
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
     * Get the formatted date and time this profile was created.
     * Avoid using SimpleDateFormat as it is not thread-safe.
     * @return the createdDate as a formatted String.
     */
    public String getCreatedDate() {
        return String.format("%1$TD %1$TT", createdDate);
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
     *
     */
    public double getDistance() {return distance;}

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
     * Sets the schedule. Should only be used for displaying needs.
     * Note that this method cannot be used to commit schedule changes to the database - not the owner side of the relationship
     * between schedule and profile.
     * 
     * @param schedules the schedules to set
     */
    public void setSchedules(List<Schedule> schedules) {
        this.schedules = schedules;
    }
}
