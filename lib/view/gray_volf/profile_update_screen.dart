import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/profile_card.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/profile_data_container.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/status_box.dart';

import '../../bloc/gray_volf_bloc/gray_volf_bloc.dart';
import '../../bloc/gray_volf_bloc/gray_volf_event.dart';
import '../../bloc/gray_volf_bloc/gray_volf_state.dart';
import '../../config/app_route_path.dart';
import 'gray_volf_widget/listtile_service_card.dart';

class ProfileUpdateScreen extends StatefulWidget {

  const ProfileUpdateScreen({
    super.key,
  });

  @override
  State<ProfileUpdateScreen> createState() => _ProviderProfileEditState();
}

class _ProviderProfileEditState extends State<ProfileUpdateScreen> {

  final TextEditingController firstNameController = TextEditingController(text: "John");
  final TextEditingController lastNameController = TextEditingController(text: "Doe");
  final TextEditingController emailController = TextEditingController(text: "john.doe@example.com");
  final TextEditingController phoneController = TextEditingController(text: "+9779812345678");
  final TextEditingController dateController = TextEditingController(text: "1990-05-15");
  final TextEditingController passwordController = TextEditingController(text: "password123");


  @override
  void dispose() {
    // Dispose all controllers here
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                                          child: CustomTextFieldWidget(
                                            controller: firstNameController,
                                            hintText: "",
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          child: CustomTextFieldWidget(
                                            controller : lastNameController,
                                               hintText:   ""
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
                                            child: CustomTextFieldWidget(
                                                controller: lastNameController,
                                                hintText: "",
                                              prefixIcon: Icon(Icons.person_rounded,),
                                              prefixIconColor: Colors.blueGrey,
                                            )
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          child: CustomTextFieldWidget(
                                            controller: dateController,
                                            hintText: "",
                                            prefixIcon: Icon(Icons.calendar_month,),
                                            prefixIconColor: Colors.blueGrey,
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
                                          child: CustomTextFieldWidget(
                                            controller: emailController,
                                            hintText: "",
                                            prefixIcon: Icon(Icons.email_rounded),
                                            prefixIconColor: Colors.blueGrey,
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
                                          child: CustomTextFieldWidget(
                                            controller: passwordController,
                                            hintText: "",
                                            prefixIcon: Icon(Icons.lock_outline),
                                            prefixIconColor: Colors.blueGrey,
                                            suffixIcon: Icon(Icons.keyboard_arrow_down),
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
                                          child: CustomTextFieldWidget(
                                            controller: phoneController,
                                            hintText: "",
                                            prefixIcon:Icon(Icons.call),
                                            prefixIconColor: Colors.blueGrey,
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
                                          child: customElevatedButton(
                                            text: "Cancel",
                                            onPressed: (){},
                                            backgroundColor: Colors.white,
                                            textStyle: TextStyle(color: Colors.black),
                                            borderRadius: 50,
                                            elevation: 4
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          child: customElevatedButton(
                                              text: "Update",
                                              onPressed: (){},
                                              borderRadius: 50,
                                              elevation: 0
                                          ),
                                        ),
                                      ],
                                    ),
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

