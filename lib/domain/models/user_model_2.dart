import 'package:equatable/equatable.dart';

class UserModel2 extends Equatable {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String website;

  const UserModel2({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
  });

  factory UserModel2.fromJson(Map<String, dynamic> json) {
    return UserModel2(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'website': website,
    };
  }

  @override
  List<Object?> get props => [
    name,
    email,
    address,
    phone,
    website,
  ];
}