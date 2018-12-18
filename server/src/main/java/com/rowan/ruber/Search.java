package com.rowan.ruber;

import com.rowan.ruber.model.*;
import com.rowan.ruber.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.ResultSetExtractor;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.List;
import java.util.Iterator;

@Component
public class Search{

	@Autowired
	JdbcTemplate jdbcTemplate;

    /**
     * Gets a list of profiles that match with the user
     *
     * @param repo the repository that stores the profiles
     * @param profileID id of the user
     * @param radius search radius in miles
     * @return a list of profiles that match with the user based on distance and schedule
     */
	public List<Profile> getMatches(ProfileRepository repo, int profileID, int radius) {
	    // Gets the profile object from the repository
		Profile profile = repo.findById(profileID).get();
		List<Profile> matchedProfiles = getMatchesByDistance(profileID, profile.getAddress().getLatitude(), profile.getAddress().getLongitude(), radius);
		Iterator<Profile> profileIterator = matchedProfiles.iterator();
		while(profileIterator.hasNext()) {
            Profile checkProfile = profileIterator.next();
            boolean foundMatchedProfile = false;
            String matchedSchedulesString = "";
            Iterator<Schedule> scheduleIterator = checkProfile.getSchedules().iterator();
            // Checks though each schedule and looks for a match
            while(scheduleIterator.hasNext())
            {
                Schedule checkSchedule = scheduleIterator.next();
                boolean foundMatchedSchedule = false;
                for (Schedule s: profile.getSchedules()) {
                    if(checkSchedule.updateWithMatchedTime(s))
                    {
                        foundMatchedSchedule = true;
                        foundMatchedProfile = true;
                    }
                }
                if(foundMatchedSchedule)
                    matchedSchedulesString += Day.toCharacter(checkSchedule.getDay()) + " ";
                else
                    scheduleIterator.remove();
            }
            if(foundMatchedProfile)
                checkProfile.setSchedulesString(matchedSchedulesString.trim());
            else
                profileIterator.remove(); //profile is removed from the list if no matches are found with the schedules

        }
		return matchedProfiles;
	}

	/**
	 * Gets a list of profiles that are within a specified radius of the user
     *
     * @param profileID id of the user
     * @param lat latitude that corresponds to the user's address
     * @param lng longitude that corresponds to the user's address
     * @param radius search radius in miles
     * @return a list of profiles that match with the user based on distance.
	 */
	private List<Profile> getMatchesByDistance(int profileID, double lat, double lng, double radius){
	    List<Profile> matchedProfiles = jdbcTemplate.query(
                "SELECT *, ( 3959* ACOS( COS( RADIANS(?) ) * COS( RADIANS( Latitude ) ) * COS( RADIANS( Longitude ) - RADIANS(?) ) + SIN( RADIANS(?) ) * SIN( RADIANS( Latitude ) ) ) ) AS Distance FROM address JOIN profile USING (AddressID) WHERE ProfileID <> ? HAVING Distance < ? ORDER BY Distance;",
                new Object[] {lat, lng, lat, profileID, radius},
                new ProfileRowMapper());
        for (Profile profile : matchedProfiles ) {
            List<Schedule> schedules = jdbcTemplate.query(
                    "SELECT * FROM schedule JOIN profile USING (ProfileID) WHERE EmailAddress = ?;",
                    new Object[]{profile.getEmail()},
                    new ScheduleRowMapper());
            schedules.sort(new SortByDay());
            for (Schedule schedule : schedules)
            {
                schedule.setProfile(profile);
            }
            profile.setSchedules(schedules);
        }
        return matchedProfiles;
	}

    /**
     * Truncates a double to the nearest hundredth
     * @param d double to be truncated
     * @return truncated double
     */
	private double Round(double d)
    {
        int i = (int)(d * 100);
        return (i + 0.0)/100;
    }

	public class ProfileResultSetExtractor implements ResultSetExtractor {
        @Override
        public Object extractData(ResultSet rs) throws SQLException {
            return new Profile(rs.getString("Name"),
                    rs.getString("EmailAddress"),
                    new Address(rs.getString("StreetAddress"),
                            rs.getString("City"),
                            rs.getString("State"),
                            rs.getString("ZipCode"),
                            rs.getDouble("Latitude"),
                            rs.getDouble("Longitude")
                    ),
                    rs.getDouble("Distance"),
                    Round(rs.getDouble("Distance"))
            );
        }
    }

    public class ProfileRowMapper implements RowMapper{
        @Override
        public Object mapRow(ResultSet rs, int line) throws SQLException {
            ProfileResultSetExtractor extractor = new ProfileResultSetExtractor();
            return extractor.extractData(rs);
        }
    }

	public class ScheduleResultSetExtractor implements ResultSetExtractor{
	    @Override
        public Object extractData(ResultSet rs) throws SQLException {
            return new Schedule(Day.valueOf(rs.getString("Day")),
                    rs.getTime("GoingToRangeStart").toLocalTime(),
                    rs.getTime("GoingToRangeEnd").toLocalTime(),
                    rs.getTime("LeavingRangeStart").toLocalTime(),
                    rs.getTime("LeavingRangeEnd").toLocalTime()
            );
        }
    }

    public class ScheduleRowMapper implements RowMapper{
        @Override
        public Object mapRow(ResultSet rs, int line) throws SQLException {
            ScheduleResultSetExtractor extractor = new ScheduleResultSetExtractor();
            return extractor.extractData(rs);
        }
    }
}