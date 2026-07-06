import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/bloc/auth_service_bloc/auth_service_bloc.dart';
import 'package:todo_app/bloc/auth_service_bloc/auth_services_state.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/login/login_screen.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_grayvolf_back.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';
import 'package:todo_app/view/full_auth_screen/widgets/label.dart';

import '../../../bloc/auth_service_bloc/auth_services_event.dart';
import '../widgets/custom_icon_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isHidden = true;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> pickDOB(BuildContext context, TextEditingController dobController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }


  String? selectedValue = "Male";






  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    genderController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go("/login");
          } else if (state is GoogleSignInSuccess){
            context.go("/dashboard");
          }else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          else if (state is GoogleAuthError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context,state){
          return Stack(
            children: [
              Positioned(
                top: -90,
                right: -105,
                child: SizedBox(
                  width: 464,
                  height: 460,
                  child: Image.asset("assets/Shape.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        CustomGrayvolfBack(
                          logoPath: "assets/grayvolf.png",
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Text(
                            "Register Here",
                            textAlign: TextAlign.center,
                            style: textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Welcome to Service App!",
                            textAlign: TextAlign.center,
                            style: textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(height: 30),
                        AppLabel(text: "First Name"),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          controller: firstNameController,
                          hintText: "First Name",
                          validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? "First name is required"
                              : null,
                        ),
                        const SizedBox(height: 30),
                        AppLabel(text: "Last Name"),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          controller: lastNameController,
                          hintText: "Last Name",
                          validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? "Last name is required"
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLabel(text: "DOB"),
                                  const SizedBox(height: 10),
                                  CustomTextFieldWidget(
                                    controller: dobController,
                                    hintText: "DOB",
                                    validator: (value) =>
                                    value == null || value.isEmpty ? "DOB is required" : null,
                                    isReadOnly: true,
                                    suffixIcon: const Icon(Icons.calendar_today),
                                    onTap: () => pickDOB(context, dobController),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLabel(text: "Gender"),
                                  const SizedBox(height: 10),


                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F3F3),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedValue,
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      hint: const Text("Select Gender"),
                                      items: <String>["Male", "Female", "Other"].map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                       setState(() {
                                         selectedValue = newValue;
                                       });
                                      },
                                    ),
                                  )


                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AppLabel(text: "Mobile Number"),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          controller: mobileController,
                          hintText: "9785062420",
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? "Mobile number is required"
                              : null,
                        ),
                        const SizedBox(height: 20),
                        AppLabel(text: "Email Address"),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          controller: emailController,
                          hintText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email is required";
                            }
                            final emailRegex = RegExp(
                              "^[A-Za-z][A-Za-z0-9]*@[A-Za-z0-9]+\.com",
                            );

                            if (!emailRegex.hasMatch(value.trim())) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        AppLabel(text: "Enter password"),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          controller: passwordController,
                          hintText: "Enter Password",
                          obscureText: _isHidden,
                          suffixIcon: IconButton(
                            icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 8) {
                              return "Minimum 8 characters";
                            }

                            String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$';
                            RegExp regex = RegExp(pattern);

                            if (!regex.hasMatch(value)) {
                              return "Must include uppercase, lowercase, number & special character";
                            }

                            return null;
                          }
                        ),
                        const SizedBox(height: 20),
                        AppLabel(text: "Re-enter password"),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          controller: confirmPasswordController,
                          hintText: "Re-Enter Password",
                          obscureText: true,
                          suffixIcon: IconButton(
                            icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm password is required";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: state is AuthLoading
                              ? const Center(child: CircularProgressIndicator())
                              : customElevatedButton(
                            text: "Sign up",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  SignUpRequested(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            backgroundColor: const Color(0xFF1863F8),
                            borderRadius: 30,
                            elevation: 0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF17A9F8),
                                Color(0xFF108ED2),
                                Color(0xFF4B55E0),
                                Color(0xFF5059D3),
                                Color(0xFF2117D7),
                              ],
                            ),
                          ),
                          child: customElevatedButton(
                            text: "Already have an account!",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Color(0xFF666666),
                            ),
                            foregroundColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreens()),
                              );
                            },
                            backgroundColor: Colors.white,
                            borderRadius: 30,
                            elevation: 0,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<AuthBloc>().add(GoogleSignInRequested());
                              },
                              child: state is GoogleAuthLoading
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                ),
                              )
                                  : CustomIconContainer(
                                icon: Image.asset(
                                  "assets/images.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            // const CustomIconContainer(
                            //   icon: Icon(Icons.apple, size: 30),
                            // ),
                            // CustomIconContainer(
                            //   icon: Image.asset("assets/fb.png",
                            //       height: 40, width: 40),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
