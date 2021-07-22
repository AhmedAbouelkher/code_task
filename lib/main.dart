import 'package:code_task/Screens/Auth/login_screen.dart';
import 'package:code_task/Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controllers/controllers.dart';
import 'Helpers/PreferencesUtils/preferences_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final UserDataAPIClient _userDataAPIClient;
  late final UserDataRepository _userDataRepository;

  @override
  void initState() {
    _userDataAPIClient = UserDataAPIClient();
    _userDataRepository = UserDataRepository(apiClient: _userDataAPIClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoggedIn = AuthController.get(context).isUserLoggedIn;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserMedicalDiagnosisDataController(
            repository: _userDataRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Code Test',
        home: _isLoggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
