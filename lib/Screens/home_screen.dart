import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:code_task/Controllers/controllers.dart';
import 'package:code_task/Helpers/error_snakbar.dart';
import 'package:code_task/Helpers/exceptions.dart';
import 'package:code_task/Screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _username;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      UserMedicalDiagnosisDataController.get(context).fetchUserData();
      _username = AuthController.get(context).currentUser;
      setState(() {});
    });
    super.initState();
  }

  void _performLogout() async {
    try {
      final _result = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("You are singing out"),
              content: Text("Are you sure you want to sign out?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Logout"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          });
      if (_result == null) return;
      await AuthController.get(context).logout();
      log("USER LOGGED OUT");
    } on AppException catch (e) {
      showErrorSnackBar(context, exception: e);
    } catch (e) {
      print(e);
      showErrorSnackBar(context, message: "Unkown error happened.");
    }
  }

  void _goToSettings() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Home"),
        actions: [
          IconButton(
            onPressed: _performLogout,
            icon: Icon(Icons.login_outlined),
          ),
          IconButton(
            onPressed: _goToSettings,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Good evening :)\n${_username?.email ?? "NULL EMAIL"}"),
            SizedBox(height: 30),
            Selector<AuthController, String?>(
              selector: (_, controller) => controller.username,
              builder: (context, username, child) {
                return Text("Your username is: " + (username ?? "NULL NAME"));
              },
            ),
            Expanded(
              child: Consumer<UserMedicalDiagnosisDataController>(
                builder: (context, provider, _) {
                  final _problems = provider.problems;
                  if (_problems == null) return Center(child: CircularProgressIndicator.adaptive());
                  if (_problems.isEmpty) return Text("No Problems Found");
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: _problems.first.diabetes.first.medications.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final _medicen = _problems.first.diabetes.first.medications[index];
                      return ListTile(
                        title: Text("Title: ${_medicen.name}"),
                        subtitle: Text("Dose: ${_medicen.dose.isEmpty ? "NO DOSE" : _medicen.dose}"),
                        trailing: Text("Strength: ${_medicen.strength}"),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
