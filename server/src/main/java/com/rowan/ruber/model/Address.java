package com.rowan.ruber.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/** Class to set up the JPA Entity for the Address table in the DB. */
@Entity
public class Address {
    @Id 
    @Column(name="addressID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)   //Identity strategy for MySQL is auto increment
    private int id;

    @Column(columnDefinition="VARCHAR(45)", nullable=false)
    private String streetAddress;

    @Column(columnDefinition="VARCHAR(45)", nullable=false)
    private String city;

    @Column(columnDefinition="VARCHAR(2)", nullable=false)
    private String state;

    @Column(columnDefinition="VARCHAR(5)", nullable=false)
    private String zipCode;

    /** Default constructor for JPA. 
     *  It should not be used directly as no values will be initialized.
     */
    protected Address() {}

    /** Constructor that takes all parameters. */
    public Address(String streetAddress, String city, String state, String zipCode) {
        this.streetAddress = streetAddress;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
    } 

    /** Gets the street address. */
    public String getStreetAddress() {
        return streetAddress;
    }

    /** Gets the city. */
    public String getCity() {
        return city;
    }

    /** Gets the state. For example, NY for New York. */
    public String getState() {
        return state;
    }

    /** Gets the zip code. */
    public String zipCode() {
        return zipCode;
    }

    @Override
    /** Return the String representation for an address. */
    public String toString() {
        return String.format("%s , %s , %s %s", streetAddress, city, state, zipCode);
    }

    /** Sets the street address. Limit of 45 characters. */
    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    /** Sets the city. Limit of 45 characters.  */
    public void setCity(String city) {
        this.city = city;
    }

    /** Sets the state. Limit of 2 characters. For example, NY for New York. */
    public void setState(String state) {
        this.state = state;
    }

    /** Sets the zip code. Limit of 5 characters. */
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

}