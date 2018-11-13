package com.rowan.ruber;

import com.rowan.ruber.model.*;
import com.rowan.ruber.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.util.List;
import java.util.ArrayList;

@Component
public class Search{

	@Autowired
	JdbcTemplate jdbcTemplate;

	public List<Profile> getMatches(ProfileRepository repo, int profileID, int radius) {
		Profile profile = repo.findById(profileID).get();
		return getMatchesByDistance(profile.getAddress().getLatitude(), profile.getAddress().getLongitude(), radius);
	}

	// Change to only get the fields needed and not everything in the table.
	private List<Profile> getMatchesByDistance(double lat, double lng, double radius) {
		ArrayList<Profile> matchedProfiles = new ArrayList<>();
		jdbcTemplate.query(
				"SELECT *, ( 3959* ACOS( COS( RADIANS(?) ) * COS( RADIANS( Latitude ) ) * COS( RADIANS( Longitude ) - RADIANS(?) ) + SIN( RADIANS(?) ) * SIN( RADIANS( Latitude ) ) ) ) AS distance FROM address JOIN profile USING (AddressID) HAVING distance < ? ORDER BY distance;",
				new Object[] {lat, lng, lat, radius},
				(rs, rowNum) ->
						new Profile(rs.getString("Name"), rs.getString("EmailAddress"),
								new Address(rs.getString("StreetAddress"), rs.getString("City"), rs.getString("State"),
										rs.getString("ZipCode"), rs.getDouble("Latitude"), rs.getDouble("Longitude"))
						)
		).forEach(profile -> {
			ArrayList<Schedule> schedules = new ArrayList<Schedule>();
			jdbcTemplate.query(
					"SELECT * FROM schedule JOIN profile USING (ProfileID) WHERE EmailAddress = ?",
					new Object[]{profile.getEmail()},
					(rs, rowNum) ->
							new Schedule(profile, Day.fromInteger(rs.getInt("Day")), rs.getTime("GoingToRangeStart").toLocalTime(), rs.getTime("GoingToRangeEnd").toLocalTime(),
									rs.getTime("LeavingRangeStart").toLocalTime(), rs.getTime("LeavingRangeEnd").toLocalTime())).forEach(schedule -> schedules.add((Schedule)schedule));
			profile.setSchedules(schedules);
			matchedProfiles.add((Profile)profile);
		});
		matchedProfiles.add(new Profile("test", "test@mail.com", new Address("100 Mulica Hill", "Glassburo", "NJ", "08028", 111.1, 222.2)));
		return matchedProfiles;
	}
}