import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/app_route_path.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/profile_card.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/service_card.dart';
import 'package:todo_app/view/gray_volf/service_information_screen.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/status_box.dart';

import '../../bloc/gray_volf_bloc/gray_volf_bloc.dart';
import '../../bloc/gray_volf_bloc/gray_volf_event.dart';
import '../../bloc/gray_volf_bloc/gray_volf_state.dart';
import 'gray_volf_widget/listtile_service_card.dart';

class ProviderProfile extends StatefulWidget {

  const ProviderProfile({
    super.key,
  });

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {


  @override
  void initState() {
    // TODO: implement initState
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
                      followOrEditText: "Follow",
                      handle: "@SufiyanJin",
                      posts: "2.6M",
                      followers: "2.6M",
                      following: "1,280",
                      onFollow: () {
                        context.go("${AppRoutePath.profileScreen}/${AppRoutePath.editProfile}");
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
                              child: BlocBuilder<GrayVolfBloc, GrayVolfState>(

                                  builder: (context,state){
                                    if (state is LoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (state is LoadedState){
                                      return ListView.builder(
                                        padding: const EdgeInsets.all(12),
                                        itemCount: state.jobs.length,
                                        itemBuilder: (context, index) {
                                          final job = state.jobs[index];
                                          return JobCard(
                                            profileImage: job.profileImage,
                                            name: job.name,
                                            tag: job.tag,
                                            description: job.description,
                                            imageUrl: job.imageUrl,
                                            onDetailsTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceInformationScreen(
                                                serviceImageUrl: job.imageUrl,
                                                providerImageUrl: job.profileImage,
                                                providerName: job.name,
                                                description: job.description,
                                                location: job.location,
                                              )));
                                            },
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
                                          return const SizedBox(height: 16);
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

