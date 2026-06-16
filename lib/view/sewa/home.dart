import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/sewaverse_home/sewaverse_bloc.dart';
import 'package:todo_app/bloc/sewaverse_home/sewaverse_state.dart';

import '../../bloc/sewaverse_home/sewaverse_event.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    context.read<SewaverseBloc>().add(LoadServices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sewaverse Home "),centerTitle: true,),
      body: BlocBuilder<SewaverseBloc, SewaverseState>(
          builder: (context ,state){
            if (state is LoadingState){
              return Center(child: CircularProgressIndicator());
            }
            if (state is ErrorState){
              return Center(child: Text("Error ${state.errorMessage}"),);
            }
            if (state is LoadedState){
              final allData = state.service.data ?? [];
              if (allData.isEmpty) return const SizedBox();

              final services = allData[0].services ?? [];
              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final item = services[index];

                  return  Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item.imageUrl ?? "",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // TITLE
                          Text(
                            item.title ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // SUBTITLE
                          Text(
                            item.subtitle ?? "",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // DESCRIPTION
                          Text(item.description ?? ""),

                          const SizedBox(height: 8),

                          // LOCATION
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 5),
                              Expanded(child: Text(item.location ?? "")),
                            ],
                          ),

                          const SizedBox(height: 6),

                          // RATING
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 16),
                              const SizedBox(width: 5),
                              Text("${item.rating ?? 0}"),
                            ],
                          ),

                          const SizedBox(height: 6),

                          // PRICE
                          Text(
                            "Price: Rs ${item.price ?? 0} (${item.priceType ?? ""})",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // PROVIDER INFO
                          Row(
                            children: [

                              CircleAvatar(
                                radius: 18,
                                backgroundImage: (item.providerImageUrl != null &&
                                    item.providerImageUrl!.isNotEmpty)
                                    ? NetworkImage(item.providerImageUrl!)
                                    : null,
                                child: (item.providerImageUrl == null ||
                                    item.providerImageUrl!.isEmpty)
                                    ? const Icon(Icons.person)
                                    : null,
                              ),

                              const SizedBox(width: 10),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.providerName ?? "",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.providerId ?? ""),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // LINK
                          Text(
                            item.linkUrl ?? "",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          }
      ),
    );
  }
}
