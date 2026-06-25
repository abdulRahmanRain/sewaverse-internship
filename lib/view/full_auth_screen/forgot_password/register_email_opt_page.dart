import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/forgot_password/new_password_set_page.dart';
import 'package:todo_app/view/full_auth_screen/forgot_password/sent_reset_link_page.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_grayvolf_back.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';


class RegisterEmailOptPage extends StatefulWidget {
  const RegisterEmailOptPage({super.key});

  @override
  State<RegisterEmailOptPage> createState() => _RegisterEmailOptPageState();
}

class _RegisterEmailOptPageState extends State<RegisterEmailOptPage> {

  final List<TextEditingController> otpControllers =
  List.generate(
    6,
        (_) => TextEditingController(),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String get otpCode =>
      otpControllers.map((e) => e.text).join();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                        style: textTheme.headlineLarge
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Center(
                      child: Text(
                        "Welcome back you've\nbeen missed!",
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      "We’ve sent the OTP to your register email address. suf********@email.com",
                      style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400,height: 1.4)
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                            (index) => SizedBox(
                          width: 45,
                          child: CustomTextFieldWidget(
                            controller: otpControllers[index],
                            hintText: "-",
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            borderRadius: 50,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(child: Text(
                          "00:30 Seconds",
                          textAlign: TextAlign.center,
                          style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400)
                        )),
                        Spacer(),
                        Expanded(child: TextButton(
                            onPressed: (){},
                            child: Text(
                              "Resend OTP",
                              textAlign: TextAlign.center,
                              style: textTheme.labelMedium
                            )
                        ))
                      ],
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      child: customElevatedButton(
                          text: "Verify",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NewPasswordSetPage(),
                                ),
                              );
                            }
                          },
                          elevation: 0,
                          backgroundColor: Color(0xFF4A3AFF),
                          borderRadius: 30
                      ),
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
