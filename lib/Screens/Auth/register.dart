import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:code_task/Controllers/controllers.dart';
import 'package:code_task/Helpers/constants.dart';
import 'package:code_task/Helpers/error_snakbar.dart';
import 'package:code_task/Helpers/exceptions.dart';
import 'package:code_task/Helpers/regex.dart';
import 'package:code_task/Screens/home_screen.dart';
import 'package:code_task/Widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  bool _hasMatchedPasswords(String? passwordConfirmation) {
    final _password = _passwordTextController.text.trim();

    return _password == passwordConfirmation;
  }

  void _performRegister() async {
    bool _isFormsContentsValid = _formKey.currentState?.validate() ?? true;
    if (!_isFormsContentsValid) return;

    //? Perform Register
    final _email = _emailTextController.text.trim();
    final _password = _passwordTextController.text.trim();
    setState(() => _isLoading = true);
    try {
      final _userCred = await AuthController.get(context).registerUser(_email, _password);
      log("USER REGISTERD with ${_userCred?.user?.email ?? "NULL EMAIL"}");

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
        appBar: AppBar(),
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
                        if (!isValidPassword(password)) {
                          return "Please, Type a valid password";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: "Re-Enter your password",
                        labelText: "Password Confirmation",
                      ),
                      validator: (password) {
                        if (!isValidPassword(password)) {
                          return "Please, Type a valid password";
                        } else if (!_hasMatchedPasswords(password)) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      isLoading: _isLoading,
                      onPressed: _performRegister,
                      child: Text("Register Now"),
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
