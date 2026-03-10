class OfferedServiceResponse {
  final bool success;
  final String message;
  final OfferedServiceData data;

  OfferedServiceResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OfferedServiceResponse.fromJson(Map<String, dynamic> json) {
    return OfferedServiceResponse(
      success: json['success'],
      message: json['message'],
      data: OfferedServiceData.fromJson(json['data']),
    );
  }
}

class OfferedServiceData {
  final String id;
  final String serviceProviderId;
  final String serviceId;
  final String title;
  final String description;
  final int price;
  final String priceType;
  final int discount;
  final String discountType;
  final int overallRating;
  final bool published;
  final bool adminVerified;
  final String? workExperience;
  final String? deliveryMode;
  final String? offeringType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Service service;
  final ServiceProvider serviceProvider;
  final List<ServiceImage> images;
  final List<Location> locations;
  final List<AvailabilityDay> availabilityDays;
  final int currentRating;
  final bool isWishlisted;
  final int servicesDelivered;
  final List<TimeSlot> unavailableSlots;
  final bool allowBooking;
  final bool allowCustomerCare;

  OfferedServiceData({
    required this.id,
    required this.serviceProviderId,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.price,
    required this.priceType,
    required this.discount,
    required this.discountType,
    required this.overallRating,
    required this.published,
    required this.adminVerified,
    this.workExperience,
    this.deliveryMode,
    this.offeringType,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
    required this.serviceProvider,
    required this.images,
    required this.locations,
    required this.availabilityDays,
    required this.currentRating,
    required this.isWishlisted,
    required this.servicesDelivered,
    required this.unavailableSlots,
    required this.allowBooking,
    required this.allowCustomerCare,
  });

  factory OfferedServiceData.fromJson(Map<String, dynamic> json) {
    return OfferedServiceData(
      id: json['id'],
      serviceProviderId: json['serviceProviderId'] ?? json['serviceProvider']['id'], // safer
      serviceId: json['serviceId'] ?? json['service']['id'], // if service object exists
      title: json['title'],
      description: json['description'],
      price: json['price'],
      priceType: json['priceType'],
      discount: json['discount'],
      discountType: json['discountType'],
      overallRating: json['overallRating'] ?? 0,
      published: json['published'],
      adminVerified: json['adminVerified'],
      workExperience: json['workExperience'],
      deliveryMode: json['deliveryMode'],
      offeringType: json['offeringType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      service: Service.fromJson(json['service']),
      serviceProvider: ServiceProvider.fromJson(json['serviceProvider']),
      images: (json['images'] as List)
          .map((e) => ServiceImage.fromJson(e))
          .toList(),
      locations: (json['locations'] as List)
          .map((e) => Location.fromJson(e))
          .toList(),
      availabilityDays: (json['availabilityDays'] as List)
          .map((e) => AvailabilityDay.fromJson(e))
          .toList(),
      currentRating: json['currentRating'],
      isWishlisted: json['isWishlisted'],
      servicesDelivered: json['servicesDelivered'],
      unavailableSlots: (json['unavailableSlots'] as List)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      allowBooking: json['allowBooking'],
      allowCustomerCare: json['allowCustomerCare'],
    );
  }
}

// Service
class Service {
  final String id;
  final String name;
  final bool isSponsoredService;
  final ParentService parentService;

  Service({
    required this.id,
    required this.name,
    required this.isSponsoredService,
    required this.parentService,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      isSponsoredService: json['isSponsoredService'] ?? false,
      parentService: ParentService.fromJson(json['parentService']),
    );
  }
}

class ParentService {
  final String id;
  final String name;

  ParentService({required this.id, required this.name});

  factory ParentService.fromJson(Map<String, dynamic> json) {
    return ParentService(id: json['id'], name: json['name']);
  }
}

// Service Provider
class ServiceProvider {
  final String id;
  final String name;
  final String email;
  final String userId;
  final String providerType;
  final bool isAdminVerified;
  final DateTime createdAt;
  final List<Profile> profiles;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.email,
    required this.userId,
    required this.providerType,
    required this.isAdminVerified,
    required this.createdAt,
    required this.profiles,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userId: json['userId'],
      providerType: json['providerType'],
      isAdminVerified: json['isAdminVerified'],
      createdAt: DateTime.parse(json['createdAt']),
      profiles: (json['profiles'] as List)
          .map((e) => Profile.fromJson(e))
          .toList(),
    );
  }
}

class Profile {
  final String id;
  final String profession;
  final double overallRating;
  final int totalRatings;
  final String experience;
  final ProfileFile? file; // <-- change here

  Profile({
    required this.id,
    required this.profession,
    required this.overallRating,
    required this.totalRatings,
    required this.experience,
    this.file,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      profession: json['profession'],
      overallRating: (json['overallRating'] as num).toDouble(),
      totalRatings: json['totalRatings'],
      experience: json['experience'],
      file: json['file'] != null ? ProfileFile.fromJson(json['file']) : null,
    );
  }
}

class ProfileFile {
  final String id;
  final String url;

  ProfileFile({required this.id, required this.url});

  factory ProfileFile.fromJson(Map<String, dynamic> json) {
    return ProfileFile(
      id: json['id'],
      url: json['url'],
    );
  }
}

// Images
class ServiceImage {
  final ImageData image;

  ServiceImage({required this.image});

  factory ServiceImage.fromJson(Map<String, dynamic> json) {
    return ServiceImage(image: ImageData.fromJson(json['image']));
  }
}

class ImageData {
  final String id;
  final String url;

  ImageData({required this.id, required this.url});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(id: json['id'], url: json['url']);
  }
}

// Location
class Location {
  final String id;
  final String district;
  final String place;
  final Coordinates? coordinates; // nullable
  final int? radius;               // nullable
  final String? districtZoneId;
  final String? localityZoneId;
  final bool allOverNepal;

  Location({
    required this.id,
    required this.district,
    required this.place,
    this.coordinates,
    this.radius,
    this.districtZoneId,
    this.localityZoneId,
    required this.allOverNepal,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      district: json['district'],
      place: json['place'],
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      radius: json['radius'],
      districtZoneId: json['districtZoneId'],
      localityZoneId: json['localityZoneId'],
      allOverNepal: json['allOverNepal'] ?? false,
    );
  }
}

class Coordinates {
  final String lat;
  final String lon;

  Coordinates({required this.lat, required this.lon});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'] ?? '', // safe fallback
      lon: json['lon'] ?? '', // safe fallback
    );
  }
}

// Availability
class AvailabilityDay {
  final Availability availability;

  AvailabilityDay({required this.availability});

  factory AvailabilityDay.fromJson(Map<String, dynamic> json) {
    return AvailabilityDay(
      availability: Availability.fromJson(json['availability']),
    );
  }
}

class Availability {
  final int dayOfWeek;
  final bool isAvailable;
  final List<TimeSlot> timeSlots;

  Availability({
    required this.dayOfWeek,
    required this.isAvailable,
    required this.timeSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      dayOfWeek: json['dayOfWeek'],
      isAvailable: json['isAvailable'],
      timeSlots: (json['timeSlots'] as List)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
    );
  }
}

class TimeSlot {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isBooked: json['isBooked'],
    );
  }
}