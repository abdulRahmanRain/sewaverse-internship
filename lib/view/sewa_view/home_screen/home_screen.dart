import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helper/sewa_helper/custom_container.dart';
import 'package:todo_app/helper/shimmer_widget.dart';
import '../../../bloc/sewa_bloc/sewa_bloc.dart';
import '../../../bloc/sewa_bloc/sewa_event.dart';
import '../../../bloc/sewa_bloc/sewa_state.dart';
import '../../../bloc/sewa_booking_bloc/booking_bloc.dart';
import '../../../helper/custom_container.dart';
import '../booking_screen/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SewaBloc>().add(FetchSewaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sewaverse"),
      ),

      body: BlocBuilder<SewaBloc, SewaState>(
        builder: (context, state) {

          if (state is SewaLoading) {
            return Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 10),
                  SizedBox(
                      height: 400.8,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (context, serviceIndex) {
                            return ShimmerWidget(child: CustomContainer.shimmer());
                          }
                      )
                    )
                  ],
                ),
            );
          }
          if (state is SewaLoaded) {

            final sewaList = state.sewaModel.data ?? [];

            return ListView.builder(
              itemCount: sewaList.length,
              itemBuilder: (context, index) {

                final sewa = sewaList[index];
                final services = sewa.services ?? [];

                if (services.isEmpty) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// CATEGORY TITLE
                      Text(
                        sewa.title ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// HORIZONTAL SERVICES
                      SizedBox(
                        height: 396.8,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: services.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (context, serviceIndex) {
                            final service = services[serviceIndex];
                            double originalPrice = (service.price ?? 0).toDouble();
                            double discountPercent = 0;

                            if (service.discount != null) {
                              final discount = double.tryParse(service.discount!.amount!.toString()) ?? 0.0;
                              originalPrice = originalPrice - discount;
                              double result = (service.discount!.amount!.toDouble()/service.price!.toDouble())*100;
                              String truncated = result.toStringAsFixed(1);
                              discountPercent = double.parse(truncated);
                            }


                            return SewaCustomContainer.cardContainer(
                              imgUrl: service.imageUrl ?? "",
                              providerImage: service.providerImageUrl ?? "",
                              price: service.price ?? 0,
                              priceType: service.priceType ?? "",
                              title: service.title ?? "",
                              description: service.description ?? "",
                              providerName: service.providerName ?? "",
                              location: service.location ?? "",
                              rating: service.rating ?? 0,
                              discountPrice: originalPrice,
                              discountPercent: discountPercent.toString(),
                              onBook: () {
                                if (service.id != null) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                    ),
                                    builder: (context) => BlocProvider.value(
                                      value: BlocProvider.of<BookingBloc>(context),
                                      child: BottomSheetPage(
                                        featuredServiceID: service.id!,
                                      ),
                                    ),
                                  );
                                }
                              }
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (state is SewaError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}