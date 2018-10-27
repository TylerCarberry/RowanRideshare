package com.rowan.ruber.model;

import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 *  Class to set up the JPA Entity for the Schedule table in the database.
 *  Each schedule is represented by a day of the week and time ranges for going and leaving.
 */
public class Schedule {
    @Id
    @ManyToOne // ** need to decide on fetch type -> Eager or Lazy ?
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
     *  Constructor that takes all parameters.
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
     *  Return the profile associated with this schedule.
     */
    public Profile getProfile() {
        return profile;
    }

    /**
     *  Return the day associated with this schedule.
     */
    public Day getDay() {
        return day;
    }

    /**
     *  Return the going to start time for the schedule.
     */
    public LocalTime getGoingToStart() {
        return goingToStart;
    }

    /**
     *  Return the going to end time for the schedule.
     */
    public LocalTime getGoingToEnd() {
        return goingToEnd;
    }

    /**
     *  Return the leaving start time for the schedule.
     */
    public LocalTime getLeavingStart() {
        return leavingStart;
    }

    /**
     *  Return the leaving end time for the schedule.
     */
    public LocalTime getLeavingEnd() {
        return leavingEnd;
    }

    /**
     *  Return the String representation of a schedule. Currently a stub.
     */
    @Override
    public String toString() {
        return "STUB FOR SCHEDULE";
    }

    /**
     *  Sets the day for the schedule to the given day.
     */
    public void setDay(Day day) {
        this.day = day;
    }

    /**
     *  Sets the going to start time to the given time.
     */
    public void setGoingToStart(LocalTime time) {
        goingToStart = time;
    }

    /**
     *  Sets the going to end time to the given time.
     */
    public void setGoingToEnd(LocalTime time) {
        goingToEnd = time;
    }

    /**
     *  Sets the leaving start time to the given time.
     */
    public void setLeavingStart(LocalTime time) {
        leavingStart = time;
    }

    /**
     *  Sets the leaving end time to the given time.
     */
    public void setLeavingEnd(LocalTime time) {
        leavingEnd = time;
    }

}