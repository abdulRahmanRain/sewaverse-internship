import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/sewaverse_cubit/sewaverse_state_cubit.dart';
import '../../cubit/sewaverse_cubit/sewaverse_cubit.dart';

class CubitHome extends StatefulWidget {
  const CubitHome({super.key});

  @override
  State<CubitHome> createState() => _CubitHomeState();
}

class _CubitHomeState extends State<CubitHome> {

  @override
  void initState() {
    super.initState();
    context.read<SewaverseCubit>().getService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SewaverseCubit, SewaverseStateCubit>(
        builder: (context, state) {

          if (state is CubitLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CubitErrorState) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is CubitLoadedState) {
            final allData = state.sewaverse.data ?? [];
            if (allData.isEmpty) return const SizedBox();
            final services = allData[0].services ?? [];

            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {

                final item = services[index];

                return Card(
                  child: ListTile(
                    title: Text(item.title ?? ""),
                    subtitle: Text(item.description ?? ""),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
