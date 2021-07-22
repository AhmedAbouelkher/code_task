import 'dart:developer';

import 'package:code_task/Helpers/test_widgets_keys.dart';
import 'package:flutter/material.dart';

import 'package:code_task/Controllers/controllers.dart';
import 'package:code_task/Helpers/constants.dart';
import 'package:code_task/Helpers/error_snakbar.dart';
import 'package:code_task/Helpers/exceptions.dart';
import 'package:code_task/Helpers/regex.dart';
import 'package:code_task/Widgets/widgets.dart';

import '../home_screen.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final GlobalKey<FormState> _formKey;
  bool _isLoading = false;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _goToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
  }

  void _performLogin() async {
    bool _isFormsContentsValid = _formKey.currentState?.validate() ?? true;
    if (!_isFormsContentsValid) return;

    //? Perform login
    final _email = _emailTextController.text.trim();
    final _password = _passwordTextController.text.trim();

    setState(() => _isLoading = true);
    try {
      final _userCred = await AuthController.get(context).loginUser(_email, _password);

      log("USER LOGGED IN with ${_userCred?.user?.email ?? "NULL EMAIL"}");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
        (route) => false,
      );
    } on AppException catch (e) {
      showErrorSnackBar(context, exception: e);
    } catch (e) {
      print(e);
      showErrorSnackBar(context, message: "Unkown error happened.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: kHomePadding,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: "example@mail.com",
                        labelText: "E-mail",
                      ),
                      validator: (value) {
                        if (!isValidEmail(value)) {
                          return "Please, Type a valid Email address";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        labelText: "Password",
                      ),
                      validator: (password) {
                        // if (!isValidPassword(password)) {
                        //   return "Please, Type a valid password";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      key: WidgetTestKeys.loginKey,
                      isLoading: _isLoading,
                      onPressed: _performLogin,
                      child: Text("Login"),
                    ),
                    TextButton(
                      onPressed: _goToRegister,
                      child: Text("Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
