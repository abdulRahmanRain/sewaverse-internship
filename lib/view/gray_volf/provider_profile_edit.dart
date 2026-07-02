import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/app_route_path.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/profile_card.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/profile_data_container.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/status_box.dart';

import '../../bloc/gray_volf_bloc/gray_volf_bloc.dart';
import '../../bloc/gray_volf_bloc/gray_volf_event.dart';
import '../../bloc/gray_volf_bloc/gray_volf_state.dart';
import 'gray_volf_widget/listtile_service_card.dart';

class ProviderProfileEdit extends StatefulWidget {

  const ProviderProfileEdit({
    super.key,
  });

  @override
  State<ProviderProfileEdit> createState() => _ProviderProfileEditState();
}

class _ProviderProfileEditState extends State<ProviderProfileEdit> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();


  @override
  void initState() {
    context.read<GrayVolfBloc>().add(GetJobEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<GrayVolfBloc, GrayVolfState>(
            builder: (context,state){
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LoadedState){
                final data = state.jobs;

                return Column(
                  children: [
                    ProfileCard(
                      backgroundImageUrl: data[0].imageUrl ?? "",
                      profileImageUrl: data[0].profileImage ?? "https://example.com/profile.jpg",
                      name: data[0].name ?? "Sufiyan Jin",
                      followOrEditText: "Edit",
                      handle: "@SufiyanJin",
                      posts: "2.6M",
                      followers: "2.6M",
                      following: "1,280",
                      onFollow: () {
                        context.go("${AppRoutePath.profileScreen}/${AppRoutePath.updateProfile}");
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        StatBox(icon: Icons.post_add, label: "Posts", value: "2.6M"),
                        StatBox(icon: Icons.people, label: "Followers", value: "2.6M"),
                        StatBox(icon: Icons.person_add, label: "Following", value: "1,280"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      dividerColor: Colors.grey.shade200,
                      tabs: [
                        Tab(text: "Wall"),
                        Tab(text: "Service"),
                      ],
                    ),
                    Expanded(
                      child:  TabBarView(
                        children: [
                          Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "SufiyanJin",
                                            iconColor: Colors.blueGrey,
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "saifi",
                                            iconColor: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "SufiyanJin@gmail.com",
                                            icon: Icons.person,
                                            iconColor: Colors.blueGrey,
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "28/0/1989",
                                            icon: Icons.calendar_month,
                                            iconColor: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "sufiyan@gmail.com",
                                            icon: Icons.person,
                                            iconColor: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "***********",
                                            icon: Icons.lock_outline,
                                            iconColor: Colors.blueGrey,
                                            trailing: Icon(Icons.keyboard_arrow_down),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ProfileDataContainer(
                                            title: "+91-9785097850",
                                            icon: Icons.call,
                                            iconColor: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Divider(
                                    color: Colors.grey.shade200,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 20,),
                                  ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text("Settings", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 1.2,
                                      letterSpacing: 0.15,
                                      color: Color(0xFF808080),
                                    ),),
                                    trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue,size: 18),
                                  ),
                                  const SizedBox(height: 10,),
                                  ListTile(
                                    leading: Icon(Icons.person_rounded),
                                    title: Text("About Us", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 1.2,
                                      letterSpacing: 0.15,
                                      color: Color(0xFF808080),
                                    ),),
                                    trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue,size: 18,),
                                  ),
                                  const SizedBox(height: 10,),
                                  ListTile(
                                    leading: Icon(Icons.logout),
                                    title: Text("Log Out", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 1.2,
                                      letterSpacing: 0.15,
                                      color: Color(0xFF808080),
                                    ),),
                                    trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue,size: 18),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Center(
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
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 16); // gap of 16px between items
                                        },
                                        itemCount: state.jobs.length,
                                        itemBuilder: (context, index) {
                                          final job = state.jobs[index];
                                          return ListTileServiceCard(

                                            description: job.description,
                                            imageUrl: job.imageUrl,
                                            title: "Service Title",
                                            onBook: () {  },
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
                              )
                          ),

                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }
}

