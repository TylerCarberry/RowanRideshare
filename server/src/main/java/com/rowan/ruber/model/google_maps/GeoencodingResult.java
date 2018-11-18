
package com.rowan.ruber.model.google_maps;

import java.util.ArrayList;
import java.util.List;

/**
 * Result from the Google Maps Geoencoding API that converts a string address to latitude and longitude
 */
public class GeoencodingResult {

    private List<Result> results;
    private String status;

    public GeoencodingResult() {
        results = new ArrayList<>();
    }

    public List<Result> getResults() {
        return results;
    }

    public void setResults(List<Result> results) {
        this.results = results;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
