import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/view/full_auth_screen/forgot_password/sent_reset_link_page.dart';
import 'package:todo_app/view/full_auth_screen/register/register_screen.dart';
import 'package:todo_app/view/full_auth_screen/widgets/custom_textfield_widget.dart';
import 'package:todo_app/view/full_auth_screen/widgets/label.dart';
import '../../../bloc/auth_service_bloc/auth_service_bloc.dart';
import '../../../bloc/auth_service_bloc/auth_services_state.dart';
import '../../../services/auth_service/auth_services.dart';
import '../widgets/custom_icon_container.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreens> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null && context.mounted) {
        context.go("/dashboard");
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In failed: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    GoogleSignIn.instance.initialize(
      serverClientId: "831387944311-a96m2jdoqjeao5lp9bdvmd9g94dejhj4.apps.googleusercontent.com"
    );
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go("/dashboard");
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

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
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 90),
                        Center(
                          child: Text(
                            "Login Here",
                            textAlign: TextAlign.center,
                            style: textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Welcome Back You've\nbeen missed!",
                            textAlign: TextAlign.center,
                            style: textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(height: 30),
                        AppLabel(text: "Email Address"),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 30),
                        AppLabel(text: "Password"),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SentResetLinkPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot your password?",
                              textAlign: TextAlign.right,
                              style: textTheme.labelMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: customElevatedButton(
                            text: "Sign in",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final authService = AuthService();
                                  final user = await authService.signInWithEmail(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  if (user != null) {
                                    context.go("/dashboard");
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Signin failed: $e")),
                                  );
                                }
                              }
                            },
                            backgroundColor: const Color(0xFF1863F8),
                            borderRadius: 30,
                            elevation: 0,
                          ),
                        ),

                        const SizedBox(height: 20),
                        // Register button
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
                            text: "Don't have an account?",
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
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            backgroundColor: Colors.white,
                            borderRadius: 30,
                            elevation: 0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Skip button
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
                            text: "Skip for Now",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Color(0xFF363636),
                            ),
                            foregroundColor: Colors.black,
                            onPressed: () {},
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
                              onTap: () => _handleGoogleSignIn(context),
                              child: CustomIconContainer(
                                icon: Image.asset("assets/images.png", height: 20, width: 20),
                              ),
                            ),
                            const CustomIconContainer(
                              icon: Icon(Icons.apple, size: 30),
                            ),
                            CustomIconContainer(
                              icon: Image.asset("assets/fb.png",
                                  height: 40, width: 40),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
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
