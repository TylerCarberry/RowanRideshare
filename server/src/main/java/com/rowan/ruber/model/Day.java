package com.rowan.ruber.model;

import java.io.Serializable;

/**
 *  Enumerated Type to represent the days of the week. Used for Schedule.
 */
public enum Day implements Serializable {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY;

    public static Day fromInteger(int x) {
        switch(x) {
            case 0:
                return MONDAY;
            case 1:
                return TUESDAY;
            case 2:
                return WEDNESDAY;
            case 3:
                return THURSDAY;
            case 4:
                return FRIDAY;
            case 5:
                return SATURDAY;
            case 6:
                return SUNDAY;
            default:
                return null;
        }
    }
}