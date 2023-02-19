
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResMap extends StatefulWidget {
  ResMap({Key? key}) : super(key: key);

  @override
  State<ResMap> createState() => _ResMapState();
}

class _ResMapState extends State<ResMap> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers =<MarkerId, Marker>{
  };
  void initMarker(specify, specifyID) async {
    var markerIdval = specifyID;
    final MarkerId markerId = MarkerId(markerIdval);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(specify['latitude'],specify['longitude']),
        infoWindow: InfoWindow(
            title: specify['name'],
            snippet: specify['category']
        )
    );
    setState(() {
      markers[markerId] = marker;
    });
  }
  getMarkerData() async{
    FirebaseFirestore.instance.collection("pharmacy").get().then((myMockData){
      if(myMockData.docs.isNotEmpty){
        for(int i=0; i< myMockData.docs.length;i++){
          initMarker(myMockData.docs[i].data(), myMockData.docs[i].id);
        }
      }
    });
  }
  void initState(){
    getMarkerData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  GoogleMap(
      onMapCreated: (GoogleMapController x) {
        mapController = x;
      },
      initialCameraPosition: const CameraPosition(
          target: LatLng(29.033333, 30.333334), zoom: 6),
      markers: Set<Marker>.of(markers.values),);
  }
}


