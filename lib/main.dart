import 'package:flutter/material.dart';
import 'package:flutter_forms/pages/register_form_page.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat.yMMMd();
    print(dateFormat.format(DateTime.now()));
    return GestureDetector(
      onTap: () {
        print('unfocus main: $context');
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
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
