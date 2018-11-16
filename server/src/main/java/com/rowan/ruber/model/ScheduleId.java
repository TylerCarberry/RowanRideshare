package com.rowan.ruber.model;

import java.io.Serializable;

/** 
 * Class to model composite key for Schedule class
 */
public class ScheduleId implements Serializable {
    private Profile profile;
    private Day day;

    public ScheduleId() {}

    public ScheduleId(Profile profile, Day day) {
        this.profile = profile;
        this.day = day;
    }

    @Override
    public boolean equals(Object o) {

        if (o == this) {
            return true;
        }
        if (!(o instanceof Schedule)) {
            return false;
        }
        Schedule other = (Schedule) o;
        return this.profile.getId() == other.getProfile().getId() && this.day.toString().equals(other.getProfile().toString());
    }

    @Override
    public int hashCode() {
        return profile.hashCode() * day.hashCode();
    }
}