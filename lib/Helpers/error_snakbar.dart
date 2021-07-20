import 'package:code_task/Helpers/exceptions.dart';
import 'package:flutter/material.dart';

///Show an error snackbar.
void showErrorSnackBar(BuildContext context, {AppException? exception, String? message}) {
  assert(message == null || exception == null, "You should choose between providing an exception or an error message.");
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? exception!.message),
    ),
  );
}
