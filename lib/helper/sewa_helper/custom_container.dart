import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import '../../custom_painter/painter.dart';
import '../shimmer_widget.dart';
import 'custom_cricle_avtar.dart';

class SewaCustomContainer {
  static Widget cardContainer({
    required String imgUrl,
    required String providerImage,
    required int price,
    required String priceType,
    required String title,
    required String description,
    required String providerName,
    required String location,
    required int rating,
    required double discountPrice,
    String? discountPercent,
    final VoidCallback? onBook
  }) {
    return GestureDetector(
      onTap: onBook,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 330, // fixed width for horizontal scroll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              Stack(
                children: [
                  Container(
                    height: 278.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imgUrl.isNotEmpty
                            ? imgUrl
                            : "https://via.placeholder.com/150"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // price card
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: Card(
                      color: const Color(0xCC023994),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: priceType == "SESSION"
                            ? Row(
                          children: [
                            Text(
                              "Rs. $price",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                height: 28 / 18,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "/$priceType",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                height: 1.33,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "Starting from:",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 16 / 12,
                              ),
                            ),
                            Text(
                              "Rs. $price",
                              style: const TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                                decorationThickness: 1.3

                              ),
                            ),
                            Text(
                              "Rs. ${discountPrice ?? price}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 28 / 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (discountPrice<price)
                    Positioned(
                      top: 0,
                      right: 5,
                      child: RibbonBanner(text: "${discountPercent!}%",subtext: "OFF",),
                    )
                ],
              ),

              // title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.isNotEmpty ? title : "No Title",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description.isNotEmpty ? description : "No Description",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        // provider image
                        CustomCircleAvtar.providerAvatar(providerName: providerName, providerImage: providerImage,radius: 18),
                        const SizedBox(width: 8),

                        //Provider name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(providerName.isNotEmpty
                                  ? providerName
                                  : "Unknown"),
                              Text(
                                location.isNotEmpty ? location : "Unknown",
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 16 / 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // rating
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
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
                          child:   const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(rating.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  static Widget simmmer(){
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 330,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE PLACEHOLDER
            Container(
              height: 278.8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            /// DETAILS PLACEHOLDER
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TITLE PLACEHOLDER
                  Container(
                    height: 14,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// DESCRIPTION PLACEHOLDER
                  Container(
                    height: 12,
                    width: 230,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      /// PROVIDER IMAGE PLACEHOLDER
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade300,
                      ),

                      const SizedBox(width: 8),

                      /// PROVIDER NAME + LOCATION
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 12,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 10,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// RATING PLACEHOLDER
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget bookingShimmer() {
    return SizedBox(
      height: AppSizes.imageHeightMedium + 110,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE PLACEHOLDER
          Container(
            height: AppSizes.fontMedium,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
            ),
          ),
          const SizedBox(height: AppSizes.paddingSM),
          /// TITLE PLACEHOLDER
          Container(
            height: AppSizes.fontMedium,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
            ),
          ),
          const SizedBox(height: AppSizes.paddingSM),
          /// IMAGE PLACEHOLDER
          Container(
            height: AppSizes.imageHeightSmall,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius:
              BorderRadius.circular(AppSizes.borderRadiusLarge),
            ),
          ),

          /// DETAILS PLACEHOLDER
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingSM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITLE PLACEHOLDER
                Container(
                  height: AppSizes.fontMedium,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius:
                    BorderRadius.circular(AppSizes.borderRadiusSmall),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingSM),

                /// DESCRIPTION PLACEHOLDER
                Container(
                  height: AppSizes.fontNormal,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius:
                    BorderRadius.circular(AppSizes.borderRadiusSmall),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingLG),

                Row(
                  children: [

                    /// PROVIDER IMAGE PLACEHOLDER
                    CircleAvatar(
                      radius: AppSizes.avatarSmall,
                      backgroundColor: Colors.grey.shade500,
                    ),

                    const SizedBox(width: AppSizes.paddingSM),

                    /// PROVIDER NAME + LOCATION
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            height: AppSizes.fontNormal,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadiusSmall),
                            ),
                          ),

                          const SizedBox(height: AppSizes.paddingXS),

                          Container(
                            height: AppSizes.fontSmall,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadiusSmall),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// RATING PLACEHOLDER
                    Container(
                      height: AppSizes.iconLarge,
                      width: AppSizes.iconLarge,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusSmall),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}