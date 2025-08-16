import 'dart:math' as math;

import 'package:get/get.dart';
import '../models/working_space_model.dart';

class SearchControllerX extends GetxController {
  // Convert mock data to WorkSpace objects
  final List<WorkSpace> _spaces = mockPlacesJson
      .map((json) => WorkSpace.fromJson(json))
      .toList();

  // Observable lists
  RxList<WorkSpace> filteredSpaces = <WorkSpace>[].obs;
  RxString selectedLocation = ''.obs;
  RxString selectedPrice = ''.obs;
  RxString searchQuery = ''.obs;

  // Getters for unique locations and prices
  List<String> get locations => _spaces
      .where((space) => space.location != null && space.location!.isNotEmpty)
      .map((space) => space.location!)
      .toSet()
      .toList()
    ..sort();

  List<String> get prices => _spaces
      .where((space) => space.ratePerHr != null)
      .map((space) => space.ratePerHr!.toInt().toString())
      .toSet()
      .toList()
    ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));

  @override
  void onInit() {
    super.onInit();
    filteredSpaces.value = List.from(_spaces);
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _filterSpaces();
  }

  void onLocationFilterChanged(String? location) {
    selectedLocation.value = location ?? '';
    _filterSpaces();
  }

  void onPriceFilterChanged(String? price) {
    selectedPrice.value = price ?? '';
    _filterSpaces();
  }

  void clearFilters() {
    selectedLocation.value = '';
    selectedPrice.value = '';
    searchQuery.value = '';
    filteredSpaces.value = List.from(_spaces);
  }

  void _filterSpaces() {
    filteredSpaces.value = _spaces.where((space) {
      // Search filter (name, location, or branch/description)
      final matchesSearch = searchQuery.value.isEmpty || _matchesSearchCriteria(space);
      
      // Location filter
      final matchesLocation = selectedLocation.value.isEmpty ||
          space.location == selectedLocation.value;
      
      // Price filter
      final matchesPrice = selectedPrice.value.isEmpty ||
          (space.ratePerHr != null && 
           space.ratePerHr!.toInt().toString() == selectedPrice.value);

      return matchesSearch && matchesLocation && matchesPrice;
    }).toList();
  }

  bool _matchesSearchCriteria(WorkSpace space) {
    final query = searchQuery.value.toLowerCase();
    
    // Search in name
    if (space.name != null && 
        space.name!.toLowerCase().contains(query)) {
      return true;
    }
    
    // Search in location (city)
    if (space.location != null && 
        space.location!.toLowerCase().contains(query)) {
      return true;
    }
    
    // Search in description (branch info)
    if (space.description != null && 
        space.description!.toLowerCase().contains(query)) {
      return true;
    }
    
    return false;
  }

  // Helper methods for UI
  String getSpaceName(WorkSpace space) => space.name ?? 'Unknown Space';
  String getSpaceLocation(WorkSpace space) => space.location ?? 'Unknown Location';
  String getSpaceImage(WorkSpace space) => space.image ?? '';
  String getSpacePrice(WorkSpace space) => space.ratePerHr?.toInt().toString() ?? '0';
  String getSpaceDescription(WorkSpace space) => space.description ?? '';
  
  // Method to get space by ID
  WorkSpace? getSpaceById(String id) {
    try {
      return _spaces.firstWhere((space) => space.id == id);
    } catch (e) {
      return null;
    }
  }

  // Method to get nearby spaces (if needed for future features)
  List<WorkSpace> getNearbySpaces(double latitude, double longitude, {double radiusKm = 5}) {
    return _spaces.where((space) {
      if (space.latitude == null || space.longitude == null) return false;
      
      final distance = _calculateDistance(
        latitude, longitude, 
        space.latitude!, space.longitude!
      );
      
      return distance <= radiusKm;
    }).toList();
  }

  // Distance calculation helper (Haversine formula)
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    
    final c = 2 * math.asin(math.sqrt(a));
    
    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (math.pi / 180);
  }
}