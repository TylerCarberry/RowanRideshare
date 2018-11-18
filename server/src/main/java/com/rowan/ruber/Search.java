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

	public List<Profile> getMatches(ProfileRepository repo, int profileID, int radius) {
		Profile profile = repo.findById(profileID).get();
		List<Profile> matchedProfiles = getMatchesByDistance(profileID, profile.getAddress().getLatitude(), profile.getAddress().getLongitude(), radius);
		// Temp set up with nested loops, this can be made more efficient
		Iterator<Profile> profileIterator = matchedProfiles.iterator();
		while(profileIterator.hasNext()) {
            Profile checkProfile = profileIterator.next();
            boolean foundMatchedProfile = false;
            Iterator<Schedule> scheduleIterator = checkProfile.getSchedules().iterator();
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
                if(!foundMatchedSchedule)
                    scheduleIterator.remove();
            }
            if(!foundMatchedProfile)
                profileIterator.remove();
        }
		return matchedProfiles;
	}

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
            for (Schedule schedule : schedules)
                schedule.setProfile(profile);
            profile.setSchedules(schedules);
        }
        return matchedProfiles;
	}

	private double Round(double d)
    {
        int i = (int)(d * 10);
        return i/10;
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
                    (double)((int)(rs.getDouble("Distance")*100)/100)
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