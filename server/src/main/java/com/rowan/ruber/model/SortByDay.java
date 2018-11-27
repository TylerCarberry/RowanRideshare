package com.rowan.ruber.model;

import java.util.Comparator;

public class SortByDay implements Comparator<Schedule> {
        // Used for sorting in ascending order of
        // roll number
        public int compare(Schedule a, Schedule b)
        {
            return a.getDay().compareTo(b.getDay());
        }
}

