import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';



class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {

  MapView mapView = new MapView();
 

  List<Marker> markers = <Marker>[
    new Marker("1", "My Location",39.70036, -75.1243,
        color: Colors.blue),
    new Marker("2", "Nick's Location",39.7099, -75.1189,
        color: Colors.amber),

  ];

  showMap() {
    mapView.show(new MapOptions( showMyLocationButton: true, showCompassButton: true,
        mapViewType: MapViewType.normal,
        initialCameraPosition: new CameraPosition(new Location(39.7099, -75.1189), 15.0),
        showUserLocation: true,

        title: "RUber "));

      mapView.onMapReady.listen((_) {
      setState(() {
        mapView.setMarkers(markers);
        mapView.zoomToFit(padding: 100);


      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return new Container(child: showMap());


  }
}
