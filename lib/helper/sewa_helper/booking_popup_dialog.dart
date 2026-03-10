import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import 'custom_cricle_avtar.dart';


class BookingPopupDialog {
  static void show(
      BuildContext context, {
        required String serviceProviderName,
        required String serviceProviderImage,
        required String profilesProfession,
        required String profileExperience,
        required String profileOverallRating,
        required int dataPrice,
        required int afterDiscountPrice,
        required String dataPriceType,
        required String createdAt,
        required String percent,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLarge),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingXL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProviderInfo(
                      serviceProviderName,
                      serviceProviderImage,
                      profilesProfession,
                      profileExperience,
                      profileOverallRating,
                      createdAt,
                    ),
                    SizedBox(height: AppSizes.paddingXL),
                    _buildBookingSection(
                      dataPrice: dataPrice,
                      afterDiscountPrice: afterDiscountPrice,
                      dataPriceType: dataPriceType,
                      percent: percent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Provider info Widget

  static Widget _buildProviderInfo(
      String name,
      String image,
      String profession,
      String experience,
      String rating,
      String createdAt,
      ) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXXL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLarge),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade500, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, AppSizes.cardElevation),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CustomCircleAvtar.providerAvatar(
                  providerName: name, providerImage: image),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingXS,
                      vertical: AppSizes.paddingXS),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius:
                    BorderRadius.circular(AppSizes.borderRadiusLarge),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star,
                          color: Colors.yellow, size: AppSizes.iconNormal),
                      SizedBox(width: AppSizes.paddingXS),
                      Text(rating,
                          style: TextStyle(
                              color: Colors.white, fontSize: AppSizes.fontSmall)),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: AppSizes.paddingLG),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: AppSizes.fontMedium,
                        fontWeight: FontWeight.w600)),
                Text(profession,
                    style: const TextStyle(
                        fontSize: AppSizes.fontNormal, color: Colors.grey)),
                SizedBox(height: AppSizes.paddingXS),
                Row(
                  children: [
                    const Icon(Icons.calendar_month,
                        size: AppSizes.iconSmall, color: Colors.grey),
                    SizedBox(width: AppSizes.paddingXS),
                    Text(createdAt,
                        style: const TextStyle(
                            fontSize: AppSizes.fontSmall, color: Colors.grey)),
                    SizedBox(width: AppSizes.paddingLG),
                    const Icon(Icons.work,
                        size: AppSizes.iconSmall, color: Colors.grey),
                    SizedBox(width: AppSizes.paddingXS),
                    Text(experience,
                        style: const TextStyle(
                            fontSize: AppSizes.fontSmall, color: Colors.grey)),
                    SizedBox(width: AppSizes.paddingMD),
                    const Icon(Icons.watch_later_outlined,
                        size: AppSizes.iconSmall, color: Colors.grey),
                    SizedBox(width: AppSizes.paddingXS),
                    Text(experience,
                        style: const TextStyle(
                            fontSize: AppSizes.fontSmall, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: AppSizes.avatarNormal + 5,
            width: AppSizes.avatarNormal - 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
              border: Border.all(color: Colors.grey),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.person_rounded,
                  size: AppSizes.iconLarge, color: Color(0xFF1A237E)),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }


  // booking section
  static Widget _buildBookingSection({
    required int dataPrice,
    required int afterDiscountPrice,
    required String dataPriceType,
    required String percent,
  }) {
    bool hasDiscount = afterDiscountPrice < dataPrice;

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLarge),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade500, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, AppSizes.cardElevation),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: const Text(
              "Book this Sewa",
              style:
              TextStyle(fontSize: AppSizes.fontXLarge, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: AppSizes.paddingSM),
          __buildPricingWidget(
              dataPrice: dataPrice,
              afterDiscountPrice: afterDiscountPrice,
              percent: percent,
              dataPriceType: dataPriceType),
          SizedBox(height: AppSizes.paddingSM),
          __buildLocationInput(),
          SizedBox(height: AppSizes.paddingLG),
          __buildDateTimeInput(),
          SizedBox(height: AppSizes.paddingMD),
          __buildBookNowButton(),
        ],
      ),
    );
  }

  // pricing widget
  static Widget __buildPricingWidget({
    required int dataPrice,
    required int afterDiscountPrice,
    required String percent,
    required String dataPriceType,
  }) {
    bool hasDiscount = afterDiscountPrice < dataPrice;

    return Row(
      children: [
        if (hasDiscount) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(dataPriceType,
                      style: TextStyle(fontSize: AppSizes.fontNormal, color: Colors.grey)),
                  SizedBox(width: AppSizes.paddingXS),
                  Text("Rs. $afterDiscountPrice",
                      style: const TextStyle(
                          fontSize: AppSizes.fontXLarge, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: AppSizes.paddingSM),
              Row(
                children: [
                  Text("Rs. $dataPrice",
                      style: TextStyle(
                          fontSize: AppSizes.fontNormal,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough)),
                  SizedBox(width: AppSizes.paddingSM),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
                        color: Colors.green.shade200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingSM, vertical: AppSizes.paddingXS),
                    child: Row(
                      children: [
                        Text("$percent%",
                            style: TextStyle(
                                fontSize: AppSizes.fontNormal,
                                fontWeight: FontWeight.w400,
                                color: Colors.green.shade900)),
                        SizedBox(width: AppSizes.paddingXS),
                        Text("OFF",
                            style: TextStyle(
                                fontSize: AppSizes.fontNormal,
                                fontWeight: FontWeight.w400,
                                color: Colors.green.shade900))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          _buildLocationBadge(),
        ] else ...[
          Text("Rs. $dataPrice",
              style: const TextStyle(
                  fontSize: AppSizes.fontXLarge, fontWeight: FontWeight.bold)),
          SizedBox(width: AppSizes.paddingXS),
          Text("/$dataPriceType",
              style: TextStyle(fontSize: AppSizes.fontNormal, color: Colors.grey)),
          Spacer(),
          _buildLocationBadge(),
        ]
      ],
    );
  }

  static Widget _buildLocationBadge() {
    return Container(
      padding:
      const EdgeInsets.symmetric(vertical: AppSizes.paddingXS, horizontal: AppSizes.paddingSM),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLarge)),
      child: Row(
        children: const [
          Icon(Icons.location_on_outlined, size: AppSizes.iconSmall),
          SizedBox(width: 4),
          Text("On-Site", style: TextStyle(fontSize: AppSizes.fontNormal)),
        ],
      ),
    );
  }

  // location
  static Widget __buildLocationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.home_outlined, size: AppSizes.iconSmall, color: Color(0xCC023994)),
            const SizedBox(width: AppSizes.paddingXS),
            Text(
              "Your Exact Location",
              style: TextStyle(
                  fontSize: AppSizes.fontMedium, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(width: AppSizes.paddingXS),
            const Text("*",
                style: TextStyle(
                    fontSize: AppSizes.fontMedium, fontWeight: FontWeight.w500, color: Colors.red)),
          ],
        ),
        SizedBox(height: AppSizes.paddingXS),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                height: AppSizes.avatarNormal + AppSizes.paddingMD,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your location details",
                    hintStyle: TextStyle(
                      fontSize: AppSizes.fontMedium,
                      height: 1.2,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: AppSizes.paddingXS, horizontal: AppSizes.paddingXS),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusNormal),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSizes.paddingSM),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: AppSizes.avatarNormal + AppSizes.paddingMD,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      size: AppSizes.iconNormal,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusNormal)),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  // Date field

  static Widget __buildDateTimeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.home_outlined, size: AppSizes.iconSmall, color: Color(0xCC023994)),
            const SizedBox(width: AppSizes.paddingXS),
            Text(
              "Sewa Date & Time",
              style: TextStyle(
                  fontSize: AppSizes.fontMedium, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(width: AppSizes.paddingXS),
            const Text("*",
                style: TextStyle(
                    fontSize: AppSizes.fontMedium, fontWeight: FontWeight.w500, color: Colors.red)),
          ],
        ),
        SizedBox(height: AppSizes.paddingXS),
        SizedBox(
          height: AppSizes.avatarNormal + AppSizes.paddingMD,
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Select Sewa Date & Time",
              prefixIcon: const Icon(Icons.calendar_today_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium)),
            ),
            onTap: () {

            },
          ),
        ),
      ],
    );
  }

  // booking button
  static Widget __buildBookNowButton() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.paddingXS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HSLColor.fromAHSL(1, 238, 0.52, 0.38).toColor(),
              HSLColor.fromAHSL(1, 301, 0.57, 0.36).toColor(),
            ],
            stops: const [0.5, 1.0],
          ),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_month, color: Colors.white, size: AppSizes.iconNormal),
                SizedBox(width: AppSizes.paddingXS),
                Text(
                  "Book Now",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.fontLarge,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}