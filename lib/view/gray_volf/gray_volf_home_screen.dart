import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_bloc.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_state.dart';
import 'package:todo_app/config/app_route_path.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';
import 'package:todo_app/view/gray_volf/list_services_bottom_sheet.dart';
import 'package:todo_app/view/gray_volf/provider_list_screen.dart';
import 'package:todo_app/view/gray_volf/gray_volf_widget/service_card.dart';

import '../../bloc/auth_service_bloc/auth_service_bloc.dart';
import '../../bloc/auth_service_bloc/auth_services_event.dart';
import '../../bloc/auth_service_bloc/auth_services_state.dart';
import '../../bloc/gray_volf_bloc/gray_volf_event.dart';
import '../../services/auth_service/auth_services.dart';
import '../auth/login_screen.dart';
import '../auth/user_home_screen.dart';
import '../full_auth_screen/register/register_screen.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
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

  final _authBox = Hive.box('authBox');
  final AuthServices _authService = AuthServices();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<GrayVolfBloc>().add(GetJobEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.pop(context);
                final currentUser = _authBox.get('currentUser');
                if (currentUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserHomeScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.switch_account),
              title: const Text("Switch Account"),
              onTap: () {
                context.read<AuthBloc>().add(ListAccountsRequested());

                showDialog(
                  context: context,
                  builder: (ctx) {
                    return BlocConsumer<AuthBloc, AuthState>(
                      listener: (ctx, state) {
                        if (state is AuthAuthenticated) {
                          Navigator.pop(ctx);
                          context.pushReplacement(AppRoutePath.grayHomeScreen);
                        } else if (state is AuthError) {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (ctx, state) {
                        if (state is AuthAccountsListed) {
                          if (state.accounts.isEmpty) {
                            return const AlertDialog(
                              title: Text("No Saved Accounts"),
                              content: Text("Please add another account first."),
                            );
                          }
                          return AlertDialog(
                            title: const Text("Choose Account"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: state.accounts.map((email) {
                                return ListTile(
                                  leading: const Icon(Icons.account_circle),
                                  title: Text(email),
                                  onTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(SwitchAccountRequested(email));
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        }
                        if (state is AuthLoading) {
                          return const AlertDialog(
                            content: SizedBox(
                              height: 80,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text("Add Another Account"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("LogOut"),
              onTap: () {
                final userEmail = _authService.currentUser?.email;
                if (userEmail != null) {
                  context.read<AuthBloc>().add(SignOutRequested(userEmail));
                }
                context.pushReplacement("/login");
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),

                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderListScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 28,
                      child: ClipOval(
                        child: Icon(Icons.person_rounded),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                controller: _searchController,
                hintText: "Search tasks...",
                prefixIcon: const Icon(Icons.circle, color: Color(0xFF1863F8)),
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
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_workCategory.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: workCard(
                        bgColor: _selectedWorkType == index
                            ? const Color(0xFF1863F8)
                            : Colors.white,
                        textColor: _selectedWorkType == index
                            ? Colors.white
                            : const Color(0xFFC1C1C1),
                        text: _workCategory[index],
                        onTap: () {
                          setState(() {
                            _selectedWorkType = index;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<GrayVolfBloc, GrayVolfState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is LoadedState) {
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
                            onDetailsTap: () {
                              context.go(
                                '${AppRoutePath.grayHomeScreen}/${AppRoutePath.serviceInformationScreen}',
                                extra: job,
                              );
                            },
                          );
                        },
                      );
                    }

                    if (state is ErrorState) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return ListServicesBottomSheet();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
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
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: border,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.0,
          color: textColor,
        ),
      ),
    ),
  );
}