import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/helper/toast_helper.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/login_bloc/login_event.dart';
import '../../bloc/login_bloc/login_state.dart';
import '../../helper/eleveted_button.dart';
import '../../helper/text_field_helper.dart';

import '../../storage/local_storage/hive_storage.dart';
import '../todo_view/home_page.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); // optional

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.go("/todoHome");
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInput.textField(
                  controller: _userNameController,
                  label: "UserName",
                  hint: "Enter User Name",
                ),
                SizedBox(height: AppSizes.paddingXXL),
                TextInput.textField(
                  controller: _passwordController,
                  label: "Password",
                  hint: "Enter Your Password",
                ),
                SizedBox(height: AppSizes.paddingXXL),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }

                    return customElevatedButton(
                      text: "Login",
                      onPressed: () {
                        final userName = _userNameController.text.trim();
                        final password = _passwordController.text.trim();
                        if (userName.isEmpty) {
                          ToastHelper.show(message: "Please Enter User Name",bgColor: Colors.red);
                          return;
                        }
                        context.read<LoginBloc>().add(
                          UserLoginEvent(userName: userName,password: password),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}