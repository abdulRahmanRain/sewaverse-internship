import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helper/sewa_helper/card_container.dart';
import '../../bloc/sewa/sewa_bloc.dart';
import '../../bloc/sewa/sewa_state.dart';

class Qasewaverse extends StatefulWidget {
  const Qasewaverse({super.key});

  @override
  State<Qasewaverse> createState() => _QasewaverseState();
}

class _QasewaverseState extends State<Qasewaverse> {
  late SewaBloc sewaBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SewaBloc, SewaState>(
        builder: (context, state) {
          if (state is SewaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SewaError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is SewaLoaded) {
            final sewaData = state.sewaList;

            final allServices = sewaData
                .expand((category) => category.data ?? [])
                .expand((categoryData) => categoryData.services ?? [])
                .toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                itemCount: allServices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final service = allServices[index];

                  int originalPrice = service.price ?? 0;
                  double discountAmount = service.discount?.amount?.toDouble() ?? 0;


                  double finalPrice = originalPrice.toDouble();

                  if (discountAmount > 0) {
                      finalPrice = originalPrice - discountAmount;
                  }

                  return CardContainer.cardContainer(
                    imgUrl: service.imageUrl ?? "",
                    discountPrice: finalPrice.toDouble(),
                    price: originalPrice,
                    priceType: service.priceType ?? "",
                    title: service.title ?? "",
                    description: service.description ?? "",
                    providerName: service.providerName ?? "",
                    location: service.location ?? "",
                    providerImage: service.providerImageUrl ?? "",
                    rating: service.rating ?? 0,
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}