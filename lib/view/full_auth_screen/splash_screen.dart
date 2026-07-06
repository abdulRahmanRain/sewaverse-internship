import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/services/auth_service/auth_services.dart';
import 'package:todo_app/view/auth/login_screen.dart';
import 'package:todo_app/view/dashboard/post_dashboard_home.dart';
import 'package:todo_app/view/full_auth_screen/register/register_screen.dart';

import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthServices _authService = AuthServices();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_authService.currentUser != null) {
          context.go('/dashboard');
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreens(),
            ),
          );
        }
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
          Center(
            child: const Text(
              "App LOGO\nImage",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 2,
                height: 1.4,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF0A66C2),
                    const Color(0xFF0A66C2).withOpacity(0.75),
                    const Color(0xFF0A66C2).withOpacity(0.50),
                    const Color(0xFF0A66C2).withOpacity(0.25),
                    const Color(0xFF0A66C2).withOpacity(0.0),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 10),
                    Text(
                      "Service App",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Find a why",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF363636)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
