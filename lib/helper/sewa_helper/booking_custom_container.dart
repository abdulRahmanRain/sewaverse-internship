import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import '../../constants/app_sizes.dart';
import '../../custom_painter/painter.dart';
import 'expendable_text.dart';


class BookingItemCard extends StatefulWidget {
  final String parentServiceName;
  final String serviceName;
  final String dataTitle;
  final String dataDescription;
  final String dataPriceType;
  final String dataPrice;
  final String dataDiscount;
  final String discountPercent;
  final List<String> imageUrl;
  final VoidCallback onTap;

  const BookingItemCard({
    super.key,
    required this.parentServiceName,
    required this.serviceName,
    required this.dataTitle,
    required this.dataDescription,
    required this.dataPriceType,
    required this.dataPrice,
    required this.dataDiscount,
    required this.discountPercent,
    required this.imageUrl,
    required this.onTap
  });

  @override
  State<BookingItemCard> createState() => _BookingItemCardState();
}

class _BookingItemCardState extends State<BookingItemCard> {
  int currentIndex = 0;

  void showNext() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.imageUrl.length;
    });
  }

  void showPrev() {
    setState(() {
      currentIndex = (currentIndex - 1 + widget.imageUrl.length) % widget.imageUrl.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.imageHeightLarge,
      width: 491,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusNormal),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: Colors.grey[800], size: AppSizes.iconSmall),
                const SizedBox(width: AppSizes.paddingXS),
                Text(">", style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.fontMedium, color: Colors.grey[800])),
                const SizedBox(width: AppSizes.paddingXS),
                Text(widget.parentServiceName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.fontMedium, color: Colors.grey[800])),
                const SizedBox(width: AppSizes.paddingXS),
                Text(">", style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.fontMedium, color: Colors.grey[800])),
                const SizedBox(width: AppSizes.paddingXS),
                Text(widget.serviceName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.fontMedium, color: Colors.grey[800])),
              ],
            ),
            const SizedBox(height: AppSizes.paddingSM),
            Text(widget.dataTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppSizes.fontXXXLarge)),
            const SizedBox(height: AppSizes.paddingMD),
            Stack(
              children: [
                // Image container
                Container(
                  height: AppSizes.imageHeightMedium,
                  width: 445,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusNormal),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusNormal),
                    child: Image.network(
                      widget.imageUrl[currentIndex],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        );
                      },
                    ),
                  ),
                ),
                // Left button
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: Center(
                    child: InkWell(
                      onTap: showPrev,
                      borderRadius: BorderRadius.circular(AppSizes.avatarLarge),
                      child: Container(
                        height: AppSizes.avatarLarge,
                        width: AppSizes.avatarLarge,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios_new_outlined, size: AppSizes.iconXLarge, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                // Right button
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Center(
                    child: InkWell(
                      onTap: showNext,
                      borderRadius: BorderRadius.circular(AppSizes.avatarLarge),
                      child: Container(
                        height: AppSizes.avatarLarge,
                        width: AppSizes.avatarLarge,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                            child: Icon(Icons.arrow_forward_ios_outlined, size: AppSizes.iconXLarge, color: Colors.white)
                        ),
                      ),
                    ),
                  ),
                ),
                // Price card
                Positioned(
                  bottom: AppSizes.paddingXS,
                  left: AppSizes.paddingXS,
                  child: Card(
                    color: const Color(0xCC023994),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingSM),
                      child: widget.dataPriceType == "SESSION"
                          ? Row(
                        children: [
                          Text("Rs. ${widget.dataPrice}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontXXLarge)),
                          const SizedBox(width: AppSizes.paddingXS),
                          Text("/${widget.dataPriceType}",
                              style: TextStyle(
                                  fontSize: AppSizes.fontSmall,
                                  color: Colors.white.withOpacity(0.9))),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Starting from:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppSizes.fontMedium)),
                          Text("Rs. ${widget.dataPrice}",
                              style: const TextStyle(
                                  color: Colors.white70,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.white,
                                  decorationThickness: 1.3)),
                          Text("Rs. ${widget.dataDiscount}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontXLarge)),
                        ],
                      ),
                    ),
                  ),
                ),
                if (double.parse(widget.dataDiscount)<double.parse(widget.dataPrice) )
                  Positioned(
                    top: 0,
                    right: AppSizes.paddingSM,
                    child: RibbonBanner(text: "${widget.discountPercent}%",subtext: "OFF",),
                  )
              ],
            ),
            const SizedBox(height: AppSizes.paddingMD),
            ExpandableText(
              text: widget.dataDescription,
              maxLines: 1,
            ),
            const SizedBox(height: AppSizes.paddingXL),
            Divider(height: AppSizes.dividerHeight),
            ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Rs. ${widget.dataPrice}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.fontXXLarge
                      )
                  ),
                  const SizedBox(width: AppSizes.paddingXS),
                  Text(
                      "/${widget.dataPriceType}",
                      style: TextStyle(
                          fontSize: AppSizes.fontSmall,
                          color: Colors.black.withOpacity(0.9)
                      )
                  ),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.all(AppSizes.paddingSM),
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
                  onTap: widget.onTap,
                  child: Text("Book Now",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppSizes.fontLarge,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSizes.paddingXXL,),
            Center(
              child: customElevatedButton(text: "Back", onPressed: (){
                context.pop();
              }),
            )
          ],
        ),
      ),
    );
  }
}