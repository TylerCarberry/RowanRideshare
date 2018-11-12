package com.rowan.ruber;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.util.Iterator;

@SpringBootApplication
public class Search implements CommandLineRunner {
    @Autowired
    JdbcTemplate jdbcTemplate;
	
    // Change to only get the fields needed and not everything in the table.
    private List<Profile> getMatchesByDistance(double lat, double lng, double radius){
		List<Profile> matchedProfiles = new List<Profile>();
		jdbcTemplate.query(
			"SELECT *, ( 3959* ACOS( COS( RADIANS(?) ) * COS( RADIANS( Latitude ) ) * COS( RADIANS( Longitude ) - RADIANS(?) ) + SIN( RADIANS(?) ) * SIN( RADIANS( Latitude ) ) ) ) AS distance FROM address JOIN profile USING (AddressID) HAVING distance < ? ORDER BY distance;",
			new Object[] { lat, lng, lat, radius },
            (rs, rowNum) ->
				new Profile(rs.getString("Name"), rs.getString("EmailAddress"),
						new Address(rs.getString("StreetAddress"), rs.getString("City"), rs.getString("State"),
								rs.getString("ZipCode"), rs.getDouble(latitude), rs.getDouble(longitude))
				)
			).forEach(profile -> {
				List<Schedule> schedules = new List<Schedule>();
				jdbcTemplate.query(
						"SELECT * FROM schedule JOIN profile USING (ProfileID) WHERE EmailAddress = ?",
						new Object[] {profile.getEmail()},
						(rs, rowNum) ->
								new Schedule(profile, rs.getEnum("Day"), rs.getTime("GoingToRangeStart"), rs.GetTime("GoingToRangeEnd"),
										rs.getTime("LeavingRangeStart"), rs.getTime("LeavingRangeEnd"))).forEach(schedule -> schedules.add(schedule));
				profile.setSchedule(schedules);
				matchedProfiles.add(profile);
			});
		return matchedProfiles;
    }