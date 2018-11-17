
package com.rowan.ruber.model.google_maps;

public class Bounds {

    private Northeast northeast;
    private Southwest southwest;

    public Bounds() {
    }

    public Northeast getNortheast() {
        return northeast;
    }

    public void setNortheast(Northeast northeast) {
        this.northeast = northeast;
    }

    public Southwest getSouthwest() {
        return southwest;
    }

    public void setSouthwest(Southwest southwest) {
        this.southwest = southwest;
    }

}
