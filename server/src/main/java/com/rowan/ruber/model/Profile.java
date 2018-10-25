package com.rowan.ruber.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Table;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 * Class to set up the JPA Entity for the Profile table in the database
 * 
 * @author Benny Chen
 */
@Entity
@Table(name = "Profile")
public class Profile {
    @Id
    @Column(name="profileID")
    private int id;

    private String name;

    @Column(name="EmailAddress")
    private String email;

    // Refers to address table
    private int addressID;

    private Date createdDate;

    /** 
     *  Default constructor for JPA.
     *  It should not be used directly as no values will be initialized.
     */
    public Profile(){
        
    }

    public Profile(String name, String email, int addressID, Date createdDate){
        this.name = name;
        this.email = email;
        this.addressID = addressID;
        this.createdDate = createdDate;
    }

    /** Returns the string representation for Profile*/
    public String toString(){
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
        return String.format("Name: %s %n Email: %s %n AddressID: %d %n Created Date: %s %n", 
                            name, email, addressID, sdf.format(createdDate));
    }

    /** Gets the primary ID*/
    public int getID(){
        return id;
    }

    /** Gets the name */
    public String getName(){
        return name;
    }

    /** Gets the email */
    public String getEmail(){
        return email;
    }

    /** Gets the addressID */
    public int getAddressID(){
        return addressID;
    }

    /** Gets the createdDate */
    public Date getCreatedDate(){
        return createdDate;
    }

    /** Sets the name */
    public void setName(String name){
        this.name = name;
    }

    /** Sets the email */
    public void setEmail(String email){
        this.email = email;
    }
}
