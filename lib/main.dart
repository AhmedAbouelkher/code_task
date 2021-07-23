import 'dart:convert';

import 'package:code_task/Screens/Auth/login_screen.dart';
import 'package:code_task/Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controllers/controllers.dart';
import 'Helpers/PreferencesUtils/preferences_utils.dart';

import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthController(auth: FireAuth()),
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

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
