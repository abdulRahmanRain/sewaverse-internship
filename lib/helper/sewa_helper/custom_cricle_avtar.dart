import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';



class CustomCircleAvtar {

  static Widget providerAvatar({
    required String providerName,
    required String providerImage,
    double radius = AppSizes.avatarNormal,
  }) {

    final initials = providerName
        .split(" ")
        .map((e) => e.isNotEmpty ? e[0] : "")
        .join()
        .toUpperCase();

    return CircleAvatar(
      radius: radius,
      backgroundImage:
      providerImage.isNotEmpty ? NetworkImage(providerImage) : null,
      child: providerImage.isEmpty
          ? Text(
        initials,
        style: TextStyle(
          fontSize: AppSizes.fontLarge, // use font size constant
          fontWeight: FontWeight.w700,
          color: const Color(0xFF6B7280),
        ),
      )
          : null,
    );
  }
}