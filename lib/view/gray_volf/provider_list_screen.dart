import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_bloc.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_state.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_grayvolf_back.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';

import '../../bloc/gray_volf_bloc/gray_volf_event.dart';
import 'gray_volf_service_filterForm.dart';
import 'gray_volf_widget/provider_list_card.dart';


class ProviderListScreen extends StatefulWidget {
  const ProviderListScreen({super.key});

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {

  final TextEditingController _searchController = TextEditingController();


  final List<String> _workCategory = [
    "Painting",
    "Polishing",
    "Repair",
    "Cleaning",
    "Washing",
    "Denting",
    "Detailing",
    "Engine Work",
  ];

  int _selectedWorkType = 0;


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<GrayVolfBloc>().add(GetJobEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomGrayvolfBack(
                      logoPath: "assets/grayvolf.png",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qjP_5gAvJ8N215_VIWF_Y6UiWirqtE39yVI--POgD5l2PV7Uo3Y7gw9-&s=10",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person_rounded);
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              CustomTextFieldWidget(
                controller: _searchController,
                hintText: "Search tasks...",
                prefixIcon: Icon(Icons.circle, color: Color(0xFF1863F8),),
                suffixIcon: SizedBox(
                  width: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 1,
                        height: 30,
                        color: const Color(0xFF1863F8),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.settings),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _workCategory.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: workCard(
                              bgColor: _selectedWorkType == index ? Color(0xFF1863F8) : Colors.white,
                              textColor: _selectedWorkType == index ? Colors.white : Color(0xFFC1C1C1),
                              text: _workCategory[index],
                              onTap: (){
                                setState(() {
                                  _selectedWorkType = index;
                                });
                              }
                          ),
                        );
                      },
                    )
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(

                child: BlocBuilder<GrayVolfBloc, GrayVolfState>(

                    builder: (context,state){
                      if (state is LoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is LoadedState){
                        return ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: state.jobs.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final job = state.jobs[index];

                            return ProviderListCard(
                              name: job.name,
                              location: job.location,
                              avatarUrl: job.profileImage,
                            );
                          },
                        );
                      }

                      if (state is ErrorState) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      return const SizedBox();
                    }
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled:  true,
              builder: (context){
                return GrayVolfServiceFilterform();
              }
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


Widget workCard({
  required Color bgColor,
  required Color textColor,
  required String text,
  required VoidCallback? onTap,
  BoxBorder? border,
}){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: border
      ),
      child: Text(text,textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.0,
          color: textColor
      ), ),
    ),
  );
}