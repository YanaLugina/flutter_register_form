import 'package:flutter/material.dart';
import 'package:flutter_forms/pages/register_form_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        print('Tap ${currentFocus.hasPrimaryFocus}');
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          print('In Tap');
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Register Form Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RegisterFormPage(),
      ),
    );
  }
}
