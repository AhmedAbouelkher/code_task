import 'package:flutter/material.dart';

import 'package:code_task/Controllers/controllers.dart';
import 'package:code_task/Helpers/constants.dart';
import 'package:code_task/Widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _userNameTextController;

  @override
  void initState() {
    _userNameTextController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final _initalUsername = AuthController.get(context).username;
      _userNameTextController.text = _initalUsername ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    _userNameTextController.dispose();
    super.dispose();
  }

  void _changeUserName() async {
    var _username = _userNameTextController.text.trim();
    try {
      await AuthController.get(context).updateUsername(_username);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: SafeArea(
          child: Padding(
            padding: kHomePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Username"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _userNameTextController,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Enter your Username",
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _changeUserName,
                      child: Text("Change"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
