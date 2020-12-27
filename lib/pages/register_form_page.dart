import 'package:flutter/material.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name *'
              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number *'
              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email address'
              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Life Store'
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password *'
              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password *'
              ),
            ),
            SizedBox(height: 15.0,),
            RaisedButton(
              onPressed: () {},
              color: Colors.green,
              child: Text(
                'Submit Form',
                style: TextStyle(
                  color: Colors.white,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}