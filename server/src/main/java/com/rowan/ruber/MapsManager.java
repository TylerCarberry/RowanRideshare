package com.rowan.ruber;

import com.rowan.ruber.model.google_maps.GeoencodingResult;
import com.rowan.ruber.model.google_maps.Location;
import org.springframework.web.client.RestTemplate;

public class MapsManager {

    // If you are reading this after December 2018, our API key has been deactivated
    // To reactivate this API key, please send me your credit card info 🙂
    private static String API_KEY = "AIzaSyBUWTvOdjkdIur2IFzkEPCVTodoL7xUzJk";

    public static Location getCoordinatesFromAddress(String address) {
        String url = "https://maps.googleapis.com/maps/api/geocode/json?key=" + API_KEY + "&address=" + address;

        RestTemplate restTemplate = new RestTemplate();
        GeoencodingResult geoencodingResult = restTemplate.getForObject(url, GeoencodingResult.class);

        return geoencodingResult.getResults().get(0).getGeometry().getLocation();
    }

}
