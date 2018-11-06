package com.rowan.ruber.model;

import java.io.Serializable;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 *  Class to set up the JPA Entity for the Schedule table in the database.
 *  Each schedule is represented by a day of the week and time ranges for going and leaving.
 */
@Entity
@Table(name="schedule")
public class Schedule implements Serializable{
    @Id
    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "ProfileID")
    private Profile profile;

    @Id
    @Enumerated(EnumType.STRING)
    @Column(name="Day")
    private Day day;

    //Is it possible to use a Calendar object or something similar to abstract these?
    @Column(name="GoingToRangeStart")
    private LocalTime goingToStart;

    @Column(name="GoingToRangeEnd")
    private LocalTime goingToEnd;

    @Column(name="LeavingRangeStart")
    private LocalTime leavingStart;

    @Column(name="LeavingRangeEnd")
    private LocalTime leavingEnd;

    /**
     *  Default constructor for JPA.
     *  It should not be used directly as no values will be initialized.
     */
    public Schedule() {

    }

    /**
     * Constructor that takes all parameters.
     * 
     * @param profile the profile for this schedule
     * @param day the specified day
     * @param goingToRangeStart the start of the going to time
     * @param goingToRangeEnd the end of the going to time
     * @param leavingRangeStart the start of the leaving time
     * @param leavingRangeEnd the end of the leaving time
     */
    public Schedule(Profile profile, Day day, LocalTime goingToRangeStart, LocalTime goingToRangeEnd, 
                    LocalTime leavingRangeStart, LocalTime leavingRangeEnd) {
        this.profile = profile;
        this.day = day;
        this.goingToStart = goingToRangeStart;
        this.goingToEnd = goingToRangeEnd;
        this.leavingStart = leavingRangeStart;
        this.leavingEnd = leavingRangeEnd;
    }

    /**
     * Return the profile associated with this schedule.
     * @return the profile
     */
    public Profile getProfile() {
        return profile;
    }

    /**
     * Return the day associated with this schedule.
     * @return the day
     */
    public Day getDay() {
        return day;
    }

    /**
     * Return the going to start time for the schedule.
     * @return the goingToStart
     */
    public LocalTime getGoingToStart() {
        return goingToStart;
    }

    /**
     * Return the going to end time for the schedule.
     * @return the goingToEnd
     */
    public LocalTime getGoingToEnd() {
        return goingToEnd;
    }

    /**
     * Return the leaving start time for the schedule.
     * @return the leavingStart
     */
    public LocalTime getLeavingStart() {
        return leavingStart;
    }

    /**
     * Get the leaving end time for the schedule. 
     * @return Return the leaving end time for the schedule.
     */
    public LocalTime getLeavingEnd() {
        return leavingEnd;
    }

    /**
     * Return the String representation of a schedule. Currently a stub.
     * @return a String for this schedule 
     */
    @Override
    public String toString() {
        return "STUB FOR SCHEDULE";
    }

    /**
     * Sets the day for the schedule to the given day.
     * @param day the day to set
     */
    public void setDay(Day day) {
        this.day = day;
    }

    /**
     * Sets the going to start time to the given time.
     * @param goingToStart the goingToStart to set
     */
    public void setGoingToStart(LocalTime goingToStart) {
        this.goingToStart = goingToStart;
    }

    /**
     * Sets the going to end time to the given time.
     * @param goingToEnd the goingToEnd to set
     */
    public void setGoingToEnd(LocalTime goingToEnd) {
        this.goingToEnd = goingToEnd;
    }

    /**
     * Sets the leaving start time to the given time.
     * @param leavingStart the leavingStart to set
     */
    public void setLeavingStart(LocalTime leavingStart) {
        this.leavingStart = leavingStart;
    }

    /**
     * Sets the leaving end time to the given time. 
     * @param leavingEnd the leavingEnd to set
     */
    public void setLeavingEnd(LocalTime leavingEnd) {
        this.leavingEnd = leavingEnd;
    }

}