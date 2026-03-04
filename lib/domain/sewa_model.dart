class SewaModel {
  bool? success;
  String? message;
  List<Data>? data;

  SewaModel({this.success, this.message, this.data});

  SewaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
        services!.add(new Services.fromJson(v));
      });
    }
    displayOrder = json['displayOrder'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['displayOrder'] = this.displayOrder;
    data['isActive'] = this.isActive;
    return data;
  }
}

class Services {
  String? id;
  String? title;
  String? subtitle;
  String? description;
  String? imageUrl;
  String? location;
  int? rating;
  int? price;
  String? priceType;
  String? providerId;
  String? providerName;
  String? providerImageUrl;
  String? linkUrl;
  Discount? discount;

  Services(
      {this.id,
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
        this.discount});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    location = json['location'];
    rating = json['rating'];
    price = json['price'];
    priceType = json['priceType'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    providerImageUrl = json['providerImageUrl'];
    linkUrl = json['linkUrl'];
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['location'] = this.location;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['priceType'] = this.priceType;
    data['providerId'] = this.providerId;
    data['providerName'] = this.providerName;
    data['providerImageUrl'] = this.providerImageUrl;
    data['linkUrl'] = this.linkUrl;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}

class Discount {
  int? amount;
  String? type;

  Discount({this.amount, this.type});

  Discount.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}