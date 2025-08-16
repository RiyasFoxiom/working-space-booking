import 'package:coworking_space_booking/app/models/working_space_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';


class MapControllerX extends GetxController {
  final mapController = MapController();

  var latitude = 9.9312.obs; // Kochi
  var longitude = 76.2673.obs;

  var markers = <Marker>[].obs;

   var selectedPlace = Rxn<WorkSpace>();

  @override
  void onInit() {
    super.onInit();
    loadMarkersFromMock();
  }
void loadMarkersFromMock() {
    List<WorkSpace> places = mockPlacesJson
        .map((json) => WorkSpace.fromJson(json))
        .toList();

    markers.value = places.map((place) {
      return Marker(
        point: LatLng(place.latitude ?? 0, place.longitude ?? 0),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () {
            selectedPlace.value = place;
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 35,
          ),
        ),
      );
    }).toList();
  }
}