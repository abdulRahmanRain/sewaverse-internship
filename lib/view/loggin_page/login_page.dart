import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/helper/toast_helper.dart';

import '../../bloc/auth_bloc/login_bloc/login_bloc.dart';
import '../../bloc/auth_bloc/login_bloc/login_event.dart';
import '../../bloc/auth_bloc/login_bloc/login_state.dart';
import '../../helper/eleveted_button.dart';
import '../../helper/text_field_helper.dart';


class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingXXL),
          child: Form(
            key: _formKey,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  context.go("/todoHome");
                } else if (state is LoginFailure) {
                  ToastHelper.show(message: state.message,bgColor: Colors.red);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextInput.textField(
                    controller: _userNameController,
                    label: "UserName",
                    hint: "Enter User Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.paddingXXL),
                  TextInput.textField(
                    controller: _passwordController,
                    label: "Password",
                    hint: "Enter Your Password",
                    obscureText: true,
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
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

                          if(_formKey.currentState!.validate()){
                            final userName = _userNameController.text.trim();
                            final password = _passwordController.text.trim();

                            context.read<LoginBloc>().add(
                              UserLoginEvent(userName: userName,password: password),
                            );
                          } else {
                            ToastHelper.show(message: "Please fill all fields correctly",bgColor: Colors.red);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}