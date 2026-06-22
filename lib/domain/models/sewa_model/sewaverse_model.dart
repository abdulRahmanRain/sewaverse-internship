import 'package:equatable/equatable.dart';

class SewaverseModel extends Equatable {
  bool? success;
  String? message;
  List<Data>? data;

  SewaverseModel({this.success, this.message, this.data});

  SewaverseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [success,message,data];
}

class Data extends Equatable {
  String? id;
  String? title;
  String? description;
  List<Services>? services;
  int? displayOrder;
  bool? isActive;

  Data(
      {this.id,
        this.title,
        this.description,
        this.services,
        this.displayOrder,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    displayOrder = json['displayOrder'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['displayOrder'] = displayOrder;
    data['isActive'] = isActive;
    return data;
  }

  @override
  List<Object?> get props => [id, title,description,services,displayOrder,isActive];
}


class Services extends Equatable {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? imageUrl;
  final String? location;
  final int? rating;
  final int? price;
  final String? priceType;
  final String? providerId;
  final String? providerName;
  final String? providerImageUrl;
  final String? linkUrl;
  final Discount? discount;

  const Services({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.imageUrl,
    this.location,
    this.rating,
    this.price,
    this.priceType,
    this.providerId,
    this.providerName,
    this.providerImageUrl,
    this.linkUrl,
    this.discount,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      rating: json['rating'],
      price: json['price'],
      priceType: json['priceType'],
      providerId: json['providerId'],
      providerName: json['providerName'],
      providerImageUrl: json['providerImageUrl'],
      linkUrl: json['linkUrl'],
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'rating': rating,
      'price': price,
      'priceType': priceType,
      'providerId': providerId,
      'providerName': providerName,
      'providerImageUrl': providerImageUrl,
      'linkUrl': linkUrl,
      'discount': discount?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    description,
    imageUrl,
    location,
    rating,
    price,
    priceType,
    providerId,
    providerName,
    providerImageUrl,
    linkUrl,
    discount,
  ];
}

class Discount extends Equatable {
  int? amount;
  String? type;

  Discount({this.amount, this.type});

  Discount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
  @override
  List<Object?> get props => [amount, type];
}
