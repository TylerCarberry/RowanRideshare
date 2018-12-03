import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

var api_key = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";

class StaticMapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<StaticMapPage> {
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = new StaticMapProvider(api_key);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    new Marker("1", "My Location", 39.70036, -75.1243, color: Colors.blue),
    new Marker("2", "Nick's Location", 39.7099, -75.1189, color: Colors.amber),
  ];

  showMap() {
    mapView.show(new MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition:
            new CameraPosition(new Location(39.7099, -75.1189), 15.0),
        showUserLocation: true,
        title: "Ryde "));

    mapView.onMapReady.listen((_) {
      setState(() {
        mapView.setMarkers(markers);
        mapView.zoomToFit(padding: 100);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraPosition = new CameraPosition(new Location(39.7099, -75.1189), 15.0);
    staticMapUri = staticMapProvider.getStaticUri(
        new Location(39.7099, -75.1189), 15,
        height: 400, width: 900, mapType: StaticMapViewType.roadmap);
  }

  @override
  Scaffold build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.only(top: 10.0),
            child: new Text(
              "Tap the map to interact",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          new Container(
            height: 300.0,
            child: new Stack(
              children: <Widget>[
                new Center(
                  child: Container(
                    child: new Text(
                      "Map should show here",
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                ),
                new InkWell(
                  child: new Center(
                    child: new Image.network(staticMapUri.toString()),
                  ),
                  onTap: showMap,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
