package com.rowan.ruber.model;

import java.io.Serializable;
import java.time.LocalTime;
import java.util.Comparator;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
public class Schedule implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "scheduleID")
    private int id;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "ProfileID")
    private Profile profile;

    @Enumerated(EnumType.STRING)
    @Column(name = "Day")
    private Day day;

    @Column(name = "GoingToRangeStart")
    private LocalTime goingToStart;

    @Column(name = "GoingToRangeEnd")
    private LocalTime goingToEnd;

    @Column(name = "LeavingRangeStart")
    private LocalTime leavingStart;

    @Column(name = "LeavingRangeEnd")
    private LocalTime leavingEnd;

    /**
     * Default constructor for JPA.
     * It should not be used directly as no values will be initialized.
     */
    public Schedule() {

    }

    /**
     * Constructor that takes all parameters.
     *
     * @param profile           the profile for this schedule
     * @param day               the specified day
     * @param goingToRangeStart the start of the going to time
     * @param goingToRangeEnd   the end of the going to time
     * @param leavingRangeStart the start of the leaving time
     * @param leavingRangeEnd   the end of the leaving time
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
     * Constructor that takes all parameters except for profile.
     *
     * @param day               the specified day
     * @param goingToRangeStart the start of the going to time
     * @param goingToRangeEnd   the end of the going to time
     * @param leavingRangeStart the start of the leaving time
     * @param leavingRangeEnd   the end of the leaving time
     */
    public Schedule(Day day, LocalTime goingToRangeStart, LocalTime goingToRangeEnd,
                    LocalTime leavingRangeStart, LocalTime leavingRangeEnd) {
        this.day = day;
        this.goingToStart = goingToRangeStart;
        this.goingToEnd = goingToRangeEnd;
        this.leavingStart = leavingRangeStart;
        this.leavingEnd = leavingRangeEnd;
    }

    /**
     * Return the id associated with this profile
     *
     * @return profile id
     */
    public int getId() {
        return id;
    }

    /**
     * Return the profile associated with this schedule.
     *
     * @return the profile
     */
    public Profile getProfile() {
        return profile;
    }

    /**
     * Return the day associated with this schedule.
     *
     * @return the day
     */
    public Day getDay() {
        return day;
    }

    /**
     * Sets the day for the schedule to the given day.
     *
     * @param day the day to set
     */
    public void setDay(Day day) {
        this.day = day;
    }

    /**
     * Sets the profile for the schedule to the given profile
     *
     * @param profile the profile to set
     */
    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    /**
     * Return the going to start time for the schedule.
     *
     * @return the goingToStart
     */
    public LocalTime getGoingToStart() {
        return goingToStart;
    }

    /**
     * Sets the going to start time to the given time.
     *
     * @param goingToStart the goingToStart to set
     */
    public void setGoingToStart(LocalTime goingToStart) {
        this.goingToStart = goingToStart;
    }

    /**
     * Return the going to end time for the schedule.
     *
     * @return the goingToEnd
     */
    public LocalTime getGoingToEnd() {
        return goingToEnd;
    }

    /**
     * Sets the going to end time to the given time.
     *
     * @param goingToEnd the goingToEnd to set
     */
    public void setGoingToEnd(LocalTime goingToEnd) {
        this.goingToEnd = goingToEnd;
    }

    /**
     * Return the leaving start time for the schedule.
     *
     * @return the leavingStart
     */
    public LocalTime getLeavingStart() {
        return leavingStart;
    }

    /**
     * Sets the leaving start time to the given time.
     *
     * @param leavingStart the leavingStart to set
     */
    public void setLeavingStart(LocalTime leavingStart) {
        this.leavingStart = leavingStart;
    }

    /**
     * Get the leaving end time for the schedule.
     *
     * @return Return the leaving end time for the schedule.
     */
    public LocalTime getLeavingEnd() {
        return leavingEnd;
    }

    /**
     * Sets the leaving end time to the given time.
     *
     * @param leavingEnd the leavingEnd to set
     */
    public void setLeavingEnd(LocalTime leavingEnd) {
        this.leavingEnd = leavingEnd;
    }

    /**
     * Return the String representation of a schedule. Currently a stub.
     *
     * @return a String for this schedule
     */
    @Override
    public String toString() {
        return "STUB FOR SCHEDULE";
    }

    /**
     * Updates this schedule with the matched times between this schedule and the schedule passed in.
     *
     * @param schedule the schedule to be compared
     * @return true if there was a match, false if there was not a match
     */
    public boolean updateWithMatchedTime(Schedule schedule) {
        if ((day == schedule.getDay())
                && (goingToEnd.compareTo(schedule.getGoingToStart()) >= 0)
                && (schedule.getGoingToEnd().compareTo(goingToStart) >= 0)
                && (leavingEnd.compareTo(schedule.getLeavingStart()) >= 0)
                && (schedule.getLeavingEnd().compareTo(leavingStart) >= 0)) {
            if (goingToStart.isBefore(schedule.getGoingToStart()))
                goingToStart = schedule.getGoingToStart();
            if (goingToEnd.isAfter(schedule.getGoingToEnd()))
                goingToEnd = schedule.getGoingToEnd();
            if (leavingStart.isBefore(schedule.getLeavingStart()))
                leavingStart = schedule.getLeavingStart();
            if (leavingEnd.isAfter(schedule.getLeavingEnd()))
                leavingEnd = schedule.getLeavingEnd();
            return true;
        }
        return false;
    }


}

