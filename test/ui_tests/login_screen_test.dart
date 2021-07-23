import 'package:code_task/Controllers/auth_base_controllers.dart';
import 'package:code_task/Controllers/controllers.dart';
import 'package:code_task/Screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'login_screen_test.mocks.dart';

const _kloginEmailField = const Key("login_email_field");
const _kloginPasswordField = const Key("login_password_field");

@GenerateMocks([BaseAuth])
void main() {
  Widget makeTestableWidget({required Widget child, required BaseAuth auth}) {
    return ChangeNotifierProvider(
      create: (_) => AuthController(auth: auth),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets("email and password are empty, don't login", (WidgetTester tester) async {
    final auth = MockBaseAuth();

    final loginScreen = LoginScreen();

    when(auth.isUserLoggedIn).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(child: loginScreen, auth: auth));
    await tester.tap(find.byKey(Key("login")));

    verifyNever(auth.signInWithEmailAndPassword(email: "", password: ""));

    expect(auth.isUserLoggedIn, false);
  });

  testWidgets("email and password are invalid, don't login", (WidgetTester tester) async {
    final auth = MockBaseAuth();

    final loginScreen = LoginScreen();

    await tester.pumpWidget(makeTestableWidget(child: loginScreen, auth: auth));

    final email = "email";
    final password = "password";

    await tester.enterText(find.byKey(_kloginEmailField), email);
    await tester.enterText(find.byKey(_kloginPasswordField), password);

    await tester.tap(find.byKey(Key("login")));

    verifyNever(auth.signInWithEmailAndPassword(email: email, password: password));
  });

  testWidgets("email and password are valid, login", (WidgetTester tester) async {
    final auth = MockBaseAuth();

    final loginScreen = LoginScreen();

    final email = "ahmed@mail.com";
    final password = "my_password";

    when(auth.signInWithEmailAndPassword(email: email, password: password)).thenAnswer((_) {
      return Future.value(User(displayName: "-", email: email, phoneNumber: "-", uid: "-"));
    });

    await tester.pumpWidget(makeTestableWidget(child: loginScreen, auth: auth));

    await tester.enterText(find.byKey(_kloginEmailField), email);
    await tester.enterText(find.byKey(_kloginPasswordField), password);

    await tester.tap(find.byKey(Key("login")));

    verify(auth.signInWithEmailAndPassword(email: email, password: password)).called(1);

    when(auth.isUserLoggedIn).thenReturn(true);

    expect(auth.isUserLoggedIn, isTrue);
  });
}
