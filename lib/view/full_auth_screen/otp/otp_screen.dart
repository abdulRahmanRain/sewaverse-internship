import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/forgot_password/sent_reset_link_page.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_grayvolf_back.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final List<TextEditingController> otpControllers =
  List.generate(
    6,
        (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String get otpCode {
    return otpControllers
        .map((controller) => controller.text)
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                CustomGrayvolfBack(
                  logoPath: "assets/grayvolf.png",
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Text(
                    "OTP Sent!",
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
                    "We've been sent the otp\non your mobile number.",

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'We’ve sent the OTP to your register Mobile Number. 978****420. Change Number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: 0,
                    color: Color(0xFF666666),
                  ),
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
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Color(0xFF808080),
                      ),
                    )),
                    Spacer(),
                    Expanded(child: TextButton(
                        onPressed: (){},
                        child: Text(
                          "Resend OTP",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Color(0xFF4A3AFF),
                          ),
                        )
                    ))
                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: customElevatedButton(
                      text: "Verify",
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SentResetLinkPage()));
                      },
                      elevation: 0,
                      backgroundColor: Color(0xFF4A3AFF),
                      borderRadius: 30
                  ),
                )
              ],
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
