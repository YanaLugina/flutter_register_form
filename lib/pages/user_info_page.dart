import 'package:flutter/material.dart';
import 'package:flutter_forms/model/user.dart';

// ignore: must_be_immutable
class UserInfoPage extends StatelessWidget {

  User userInfo;
  UserInfoPage({this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
        centerTitle: true,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget> [
              ListTile(
                title: Text(
                  '${userInfo.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text('${userInfo.story}'),
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                trailing: Text('${userInfo.country}'),
              ),
              ListTile(
                title: Text(
                  '${userInfo.phone}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text(
                  '${userInfo.email}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}