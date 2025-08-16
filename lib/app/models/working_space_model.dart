import 'dart:math';

class WorkSpace {
  final String? id;
  final String? image;
  final String? name;
  final String? description;
  final String? location;
  final double? latitude;
  final double? longitude;
  final List<String>? amenities;
  final double? ratePerHr;

  WorkSpace({
    this.id,
    this.image,
    this.name,
    this.description,
    this.location,
    this.latitude,
    this.longitude,
    this.amenities,
    this.ratePerHr,
  });

  factory WorkSpace.fromJson(Map<String, dynamic> json) {
    List<String> shuffledAmenities = List<String>.from(json['amenities'] ?? []);
    shuffledAmenities.shuffle(Random());
    return WorkSpace(
      id: json['id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      amenities: shuffledAmenities,
      ratePerHr: json['ratePerHr'] != null
          ? double.tryParse(json['ratePerHr'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'amenities': amenities,
      'ratePerHr': ratePerHr,
    };
  }
}
List<Map<String, dynamic>> mockPlacesJson = [
  {
    "id": "1",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/9b329c275031a751a127e162fd87aeda/UB-Business-Centre-1-1-scaled.jpg",
    "name": "Sunny Beach",
    "description":
        "Being our 1st centre in Kerala, we take pride in joining the coworking revolution of Kochi through the Kaloorcentre. With around 100 workstations, meeting, and conference rooms, this is the ideal location for freelancers, startups, or corporates. With over 15 car and 20 bike parking spots within the compound, InnerSpaceKaloor got the best free parking facility among coworking spaces in Kochi. The centre is located within walking distance from Town Hall Metro Station (Formally known as Lisie Metro Station) and Ernakulam North (Town) Railway station.",
    "location": "Marine Drive, Kochi",
    "latitude": 9.9312,
    "longitude": 76.2673,
    "ratePerHr": 220,
    "amenities": [
      "Private Offices",
      "Open Desks",
      "Meeting Rooms",
      "Courier Handling",
      "Generator Backup",
      "High-Speed Internet",
      "24hr Access",
      "Exclusive Brand Offers",
      "Parking Facility"
    ],
  },
  {
    "id": "2",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/5e70f85812485cc290e8dea164cd8dfc/IMG-20231214-WA0029-1-scaled.jpg",
    "name": "Green Hills",
    "description":
        "Being our 1st centre in Kerala, we take pride in joining the coworking revolution of Kochi through the Kaloorcentre. With around 100 workstations, meeting, and conference rooms, this is the ideal location for freelancers, startups, or corporates. With over 15 car and 20 bike parking spots within the compound, InnerSpaceKaloor got the best free parking facility among coworking spaces in Kochi. The centre is located within walking distance from Town Hall Metro Station (Formally known as Lisie Metro Station) and Ernakulam North (Town) Railway station.",
    "location": "Fort Kochi, Kerala",
    "latitude": 9.9633,
    "longitude": 76.2425,
    "ratePerHr": 240,
    "amenities": [
      "Private Offices",
      "Open Desks",
      "Meeting Rooms",
      "Courier Handling",
      "Generator Backup",
      "High-Speed Internet",
      "24hr Access",
      "Video Conferencing",
    ],
  },
  {
    "id": "3",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/9daddae2c42097afaf5a1f5ba5a35341/office-space.webp",
    "name": "Central City Park",
    "description":
        "Being our 1st centre in Kerala, we take pride in joining the coworking revolution of Kochi through the Kaloorcentre. With around 100 workstations, meeting, and conference rooms, this is the ideal location for freelancers, startups, or corporates. With over 15 car and 20 bike parking spots within the compound, InnerSpaceKaloor got the best free parking facility among coworking spaces in Kochi. The centre is located within walking distance from Town Hall Metro Station (Formally known as Lisie Metro Station) and Ernakulam North (Town) Railway station.",
    "location": "Kaloor, Kochi",
    "latitude": 9.9840,
    "longitude": 76.2753,
    "ratePerHr": 500,
    "amenities": [
      "Private Offices",
      "Open Desks",
      "Meeting Rooms",
      "Courier Handling",
      "Generator Backup",
      "High-Speed Internet",
      "24hr Access",
    ],
  },
  {
    "id": "4",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/e4a61d1fa313e2317b880b7ccaebc7ce/Slide4_Innerspace.jpg",
    "name": "Silver Falls",
    "description":
        "Being our 1st centre in Kerala, we take pride in joining the coworking revolution of Kochi through the Kaloorcentre. With around 100 workstations, meeting, and conference rooms, this is the ideal location for freelancers, startups, or corporates. With over 15 car and 20 bike parking spots within the compound, InnerSpaceKaloor got the best free parking facility among coworking spaces in Kochi. The centre is located within walking distance from Town Hall Metro Station (Formally known as Lisie Metro Station) and Ernakulam North (Town) Railway station.",
    "location": "Edappally, Kochi",
    "latitude": 10.0266,
    "longitude": 76.3080,
    "ratePerHr": 700,
    "amenities": [
      "Private Offices",
      "Open Desks",
      "Meeting Rooms",
      "Courier Handling",
      "Generator Backup",
      "High-Speed Internet",
      "24hr Access",
      "Event Platform",
    ],
  },
  {
    "id": "5",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/9b329c275031a751a127e162fd87aeda/UB-Business-Centre-1-1-scaled.jpg",
    "name": "Historic Fort",
    "description":
        "Being our 1st centre in Kerala, we take pride in joining the coworking revolution of Kochi through the Kaloorcentre. With around 100 workstations, meeting, and conference rooms, this is the ideal location for freelancers, startups, or corporates. With over 15 car and 20 bike parking spots within the compound, InnerSpaceKaloor got the best free parking facility among coworking spaces in Kochi. The centre is located within walking distance from Town Hall Metro Station (Formally known as Lisie Metro Station) and Ernakulam North (Town) Railway station.",
    "location": "Vyttila, Kochi",
    "latitude": 10.0650,
    "longitude": 76.2330,
    "ratePerHr": 650,
    "amenities": [
      "Private Offices",
      "Open Desks",
      "Meeting Rooms",
      "Courier Handling",
      "Generator Backup",
      "High-Speed Internet",
      "24hr Access",
      "House Keeping",
    ],
  },
  {
    "id": "6",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/e4a61d1fa313e2317b880b7ccaebc7ce/Slide4_Innerspace.jpg",
    "name": "Tech Hub",
    "description":
        "Coworking hub located near Kakkanad Infopark, ideal for IT professionals and startups.",
    "location": "Kakkanad, Kochi",
    "latitude": 10.0155,
    "longitude": 76.3419,
    "ratePerHr": 550,
    "amenities": [
      "Private Cabins",
      "High-Speed Internet",
      "24hr Access",
      "Parking Facility",
      "Generator Backup",
    ],
  },
  {
    "id": "7",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/9daddae2c42097afaf5a1f5ba5a35341/office-space.webp",
    "name": "Harbor View",
    "description":
        "Premium coworking space overlooking Kochi harbor, great for corporates and freelancers.",
    "location": "Willingdon Island, Kochi",
    "latitude": 9.9580,
    "longitude": 76.2669,
    "ratePerHr": 800,
    "amenities": [
      "Conference Rooms",
      "Open Desks",
      "Courier Handling",
      "Generator Backup",
      "High-Speed Internet",
      "24hr Access",
    ],
  },
  {
    "id": "8",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/5e70f85812485cc290e8dea164cd8dfc/IMG-20231214-WA0029-1-scaled.jpg",
    "name": "Startup Bay",
    "description":
        "Affordable coworking for startups near Kalamassery metro station.",
    "location": "Kalamassery, Kochi",
    "latitude": 10.0597,
    "longitude": 76.3264,
    "ratePerHr": 300,
    "amenities": [
      "Private Offices",
      "Open Desks",
      "Meeting Rooms",
      "High-Speed Internet",
      "24hr Access",
    ],
  },
  {
    "id": "9",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/9b329c275031a751a127e162fd87aeda/UB-Business-Centre-1-1-scaled.jpg",
    "name": "The Metro Hub",
    "description":
        "Coworking near MG Road metro station, perfect for daily commuters.",
    "location": "MG Road, Kochi",
    "latitude": 9.9816,
    "longitude": 76.2835,
    "ratePerHr": 450,
    "amenities": [
      "High-Speed Internet",
      "24hr Access",
      "Parking Facility",
      "Event Platform",
    ],
  },
  {
    "id": "10",
    "image":
        "https://innerspace.work/wp-content/uploads/slider/cache/9daddae2c42097afaf5a1f5ba5a35341/office-space.webp",
    "name": "City Tower",
    "description":
        "Modern coworking inside Lulu Mall tower, Edappally.",
    "location": "Lulu Mall, Edappally, Kochi",
    "latitude": 10.0323,
    "longitude": 76.3074,
    "ratePerHr": 600,
    "amenities": [
      "Private Offices",
      "High-Speed Internet",
      "24hr Access",
      "Parking Facility",
      "House Keeping",
    ],
  },
];
