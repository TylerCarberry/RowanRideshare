package com.rowan.ruber.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;
import javax.persistence.Id;

/** Class to set up the JPA Entity for the Address table in the DB. */
@Entity
@Table(name="address")
public class Address implements Serializable{
    @Id 
    @Column(name="AddressID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)   //Identity strategy for MySQL is auto increment
    private int id;

    @Column(name="StreetAddress")
    private String streetAddress;

    @Column(name="City")
    private String city;

    @Column(name="ZipCode")
    private String zipCode;
    
    @Column(name="State")
    private String state;

    private double latitude;

    private double longitude;


    /** Default constructor for JPA. 
     *  It should not be used directly as no values will be initialized.
     */
    protected Address() {}

    /** Constructor that takes all parameters. */
    public Address(String streetAddress, String city, String state, String zipCode, double latitude, double longitude) {
        this.streetAddress = streetAddress;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.latitude = latitude;
        this.longitude = longitude;
    } 

    /**
     * Gets the AddressID.
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * Gets the street address.
     * @return the streetAddress
     */
    public String getStreetAddress() {
        return streetAddress;
    }

    /**
     * Gets the city.
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Gets the state.
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * Gets the zip code.
     * @return the zipCode
     */
    public String getZipCode() {
        return zipCode;
    }

    /**
     * Gets the latitude.
     * @return the latitude
     */
    public double getLatitude() {
        return latitude;
    }

    /**
     * Gets the longitude.
     * @return the longitude
     */
    public double getLongitude() {
        return longitude;
    }

    /** 
     * Return the String representation for an address. 
     * @return a String for this address
    */
    @Override
    public String toString() {
        return String.format("%s , %s , %s %s", streetAddress, city, state, zipCode);
    }

    /**
     * Sets the street address. Limit of 45 characters.
     * @param streetAddress the streetAddress to set
     */
    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    /**
     * Sets the city. Limit of 45 characters.
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Sets the state. Limit of 2 characters. For example, NY for New York.
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state.toUpperCase();
    }

    /**
     * Sets the zip code. Limit of 5 characters.
     * @param zipCode the zipCode to set
     */
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    /**
     * Sets the latitude.
     * @param latitude the latitude to set
     */
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    /**
     * Sets the longitude.
     * @param longitude the longitude to set
     */
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

}