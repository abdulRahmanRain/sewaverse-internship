import 'package:flutter/material.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/register/register_screen.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_icon_container.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';
import 'package:todo_app/view/full_auth_screen/widgets/label.dart';

import '../forgot_password/register_email_opt_page.dart';


class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreens> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -90,
              right: -105,
              child: SizedBox(
                width: 464,
                height: 460,
                child: Image.asset("assets/Shape.png"),
              )
          ),
          SafeArea(
            child:  SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 90,),
                    Center(
                      child: Text(
                        "Login Here",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                          letterSpacing: 0,
                          color: Color(0xFF0A66C2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Center(
                      child: Text(
                        "Welcome Back You've\nbeen missed!",

                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    AppLabel(text: "Email Address"),
                    const SizedBox(height: 20,),
                    CustomTextFieldWidget(
                      controller: emailController,
                      hintText: "abdul@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.email_rounded,
                        size: 20,
                        color: Color(0xFF1863F8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30,),
                    AppLabel(text: "Password"),
                    const SizedBox(height: 20,),
                    CustomTextFieldWidget(
                      controller: passwordController,
                      hintText: "•••••••••",
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 20,
                        color: Color(0xFF1863F8),
                      ),
                      suffixIcon: const Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: Color(0xFF1863F8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterEmailOptPage()));
                          },
                          child: Text(
                            "Forgot your password?",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Color(0xFF1F41BB),
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: customElevatedButton(
                        text: "Sing in",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          }
                        },
                        backgroundColor: Color(0xFF1863F8),
                        borderRadius: 30,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.8,vertical: 0.5),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: AlignmentGeometry.topCenter,
                              end: AlignmentGeometry.bottomCenter,
                              colors: [
                                Color(0xFF17A9F8),
                                Color(0xFF108ED2),
                                Color(0xFF4B55E0),
                                Color(0xFF5059D3),
                                Color(0xFF2117D7)
                              ]
                          )
                      ),
                      child: customElevatedButton(
                        text: "Don't have an account?",
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: 0,
                          color: Color(0xFF666666),
                        ),

                        foregroundColor: Colors.black,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          }
                        },
                        backgroundColor: Colors.white,
                        borderRadius: 30,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.8,vertical: 0.5),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: AlignmentGeometry.topCenter,
                              end: AlignmentGeometry.bottomCenter,
                              colors: [
                                Color(0xFF17A9F8),
                                Color(0xFF108ED2),
                                Color(0xFF4B55E0),
                                Color(0xFF5059D3),
                                Color(0xFF2117D7)
                              ]
                          )
                      ),
                      child: customElevatedButton(
                        text: "Skip for Now",
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: 0,
                          color: Color(0xFF363636),
                        ),

                        foregroundColor: Colors.black,
                        onPressed: (){},
                        backgroundColor: Colors.white,
                        borderRadius: 30,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Or continue with",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                          letterSpacing: 0,
                          color: Color(0xFF363636),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        CustomIconContainer(
                            icon: Image.asset("assets/images.png",height: 20,width: 20,)
                        ),
                        CustomIconContainer(
                          icon: Icon(Icons.apple,size: 30,),
                        ),
                        CustomIconContainer(
                            icon: Image.asset("assets/fb.png",height:40,width:40,)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
