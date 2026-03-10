import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/sewa_booking_bloc/booking_bloc.dart';
import '../../../bloc/sewa_booking_bloc/booking_event.dart';
import '../../../bloc/sewa_booking_bloc/booking_state.dart';
import '../../../helper/sewa_helper/booking_custom_container.dart';
import '../../../helper/sewa_helper/booking_popup_dialog.dart';
import '../../../helper/sewa_helper/custom_container.dart';
import '../../../helper/shimmer_widget.dart';


class BottomSheetPage extends StatefulWidget {
  final String featuredServiceID;

  const BottomSheetPage({super.key, required this.featuredServiceID});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(FetchBookingEvent(widget.featuredServiceID));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return ShimmerWidget(child: SewaCustomContainer.bookingShimmer());
            } else if (state is BookingLoaded) {
              final booking = state.data.data;
              DateTime createdAt = booking.serviceProvider.createdAt;
              final int discountPrice = booking.price-booking.discount;

              String formattedDate = DateFormat('MMM yyyy').format(createdAt);

              double result = (booking.discount /booking.price)*100;
              String truncated = result.toStringAsFixed(1);
              double discountPercent = double.parse(truncated);

              return BookingItemCard(
                parentServiceName: booking.service.parentService.name,
                serviceName: booking.service.name,
                dataTitle: booking.title,
                dataDescription: booking.description,
                imageUrl: booking.images.map((item) => item.image.url).toList(),
                dataPriceType: booking.priceType,
                dataPrice: booking.price.toString(),
                discountPercent: discountPercent.toString(),
                dataDiscount: discountPrice.toString(),
                onTap: (){
                  BookingPopupDialog.show(
                      context,
                      serviceProviderName: booking.serviceProvider.name,
                      serviceProviderImage: booking.serviceProvider.profiles[0].file?.url ?? "",
                      profilesProfession: booking.serviceProvider.profiles[0].profession,
                      profileExperience: booking.serviceProvider.profiles[0].experience,
                      profileOverallRating: booking.serviceProvider.profiles[0].overallRating.toString(),
                      dataPrice: booking.price,
                      percent: discountPercent.toString(),
                      dataPriceType: booking.priceType,
                      afterDiscountPrice: discountPrice,
                      createdAt: formattedDate
                  );
                }
              );
            } else if (state is BookingError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox();
          },
        )
      ),
    );
  }
}