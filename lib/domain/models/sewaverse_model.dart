class SewaverseModel {
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
        ? Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['location'] = location;
    data['rating'] = rating;
    data['price'] = price;
    data['priceType'] = priceType;
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['providerImageUrl'] = providerImageUrl;
    data['linkUrl'] = linkUrl;
    if (discount != null) {
      data['discount'] = discount!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
}
