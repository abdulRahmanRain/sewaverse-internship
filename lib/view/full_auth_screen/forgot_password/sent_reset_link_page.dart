import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/forgot_password/register_email_opt_page.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_grayvolf_back.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';

import '../widgets/label.dart';


class SentResetLinkPage extends StatefulWidget {
  const SentResetLinkPage({super.key});

  @override
  State<SentResetLinkPage> createState() => _SentResetLinkPageState();
}

class _SentResetLinkPageState extends State<SentResetLinkPage> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    CustomGrayvolfBack(
                      logoPath: "assets/grayvolf.png",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20,),
                    Center(
                      child: Text(
                        "Forgot Password?",
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
                    const SizedBox(height: 30,),
                    Center(
                      child: Text(
                        "Welcome back you've\nbeen missed!",

                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: AppLabel(text: "Email Address"),
                    ),
                    const SizedBox(height: 20,),

                CustomTextFieldWidget(
                  controller: emailController,
                  hintText: "sufiyan@gmail.com",
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

                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return "Enter a valid email";
                    }

                    return null;
                  },
                ),
                    const SizedBox(height: 30,),
                    Text(
                      "Enter the register email, and we’ve send the password reset link.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Color(0xFF474747),
                      )
                      ,),
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      child: customElevatedButton(
                          text: "Sent Reset Link",
                          onPressed: (){},
                          elevation: 0,
                          backgroundColor: Color(0xFF4A3AFF),
                          borderRadius: 30
                      ),
                    ),
                    const SizedBox(height: 30,),
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
                        text: "Go back to login",
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: 0,
                          color: Color(0xFF666666),
                        ),

                        foregroundColor: Colors.black,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterEmailOptPage()));
                        },
                        backgroundColor: Colors.white,
                        borderRadius: 30,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: -90,
              right: -105,
              child: SizedBox(
                width: 464,
                height: 460,
                child: Image.asset("assets/Shape.png"),
              )
          ),
        ],
      )
    );
  }
}
