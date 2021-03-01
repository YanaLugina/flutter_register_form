import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_forms/model/user.dart';
import 'package:flutter_forms/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _lifeStoreController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  User newUser = User();

  List<String> _countries = ['Russia', 'Germany', 'Australia', 'USA'];
  String _selectedCountry;

   FocusNode _nameFocus = FocusNode();
   FocusNode _phoneFocus = FocusNode();
   FocusNode _passwordFocus = FocusNode();
   FocusNode _passwordConfirmFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _lifeStoreController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmFocus.dispose();
  }

  void _fieldFocusChange(
      BuildContext context,
      FocusNode currentFocus,
      FocusNode nextFocus
      ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What do people call you?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(
                      Icons.delete_outline,
                      color: Colors.red
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              focusNode: _phoneFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passwordFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'Where can we reach you?',
                helperText: 'Phone format: +7(XXX) XXX-XXXX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    _phoneController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
              textInputAction: TextInputAction.done,
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'), allow: true)
              ],
              validator: (value) => _validatePhoneNumber(value)
                  ? null
                  : 'Phonenumber mast be entered as (###) ###-##-##',
              onSaved: (value) => newUser.phone = value,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email address',
                hintText: 'Enter a email address',
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              // validator: _validateEmail,
              onSaved: (value) => newUser.email = value,
            ),
            SizedBox(height: 10.0,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country?'
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                setState(() {
                  _selectedCountry = country;
                  newUser.country = country;
                });
              },
              value: _selectedCountry,
              validator: (val){
                return val == null ? 'Please select a country': null;
              },
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              controller: _lifeStoreController,
              decoration: InputDecoration(
                labelText: 'Life Store',
                hintText: 'Tell as about you self',
                helperText: 'Keep it short, this is just a demo',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              maxLines: 3,
              onSaved: (value) => newUser.story = value,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              focusNode: _passwordFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _passwordFocus, _passwordConfirmFocus);
              },
              controller: _passwordController,
              obscureText: _hidePass,
              maxLength: 12,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
              validator: _validatePassword,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              focusNode: _passwordConfirmFocus,
              controller: _confirmPasswordController,
              obscureText: _hidePass,
              maxLength: 12,
              decoration: InputDecoration(
                labelText: 'Confirm Password *',
                hintText: 'Confirm the password',
                suffixIcon: IconButton(
                  icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: Icon(Icons.border_color),
              ),
              validator: _validatePassword,
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: _submitForm,
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
  void _submitForm() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: $_selectedCountry');
      print('LifeController: ${_lifeStoreController.text}');
    } else {
      _showMessage(message: 'Form is not valid please review and correct');
    }
  }

  String _validateName(String value){
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if(value.isEmpty) {
      return 'Name is required';
    } else if(!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\-\d\d$');
    return _phoneExp.hasMatch(input);
  }

  String _validateEmail(String value) {
    if(value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid Email address';
    } else {
      return null;
    }
  }
  String _validatePassword(String value) {
    if(_passwordController.text.length != 8) {
      return '8 character required for password';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  void _showMessage({String message}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
            message,
            style: TextStyle(
              color: Colors.black,
              fontWeight:  FontWeight.w600,
              fontSize: 18.0,
            ))
      ),
    );
  }

  void _showDialog({String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Registration successful',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            '$name is now verified register form',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(
                        userInfo: newUser,
                      ),
                    ),
                );
              },
              child: Text(
                  'Verified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                )
              ),
            ),
          ],
        );
      }
    );
  }
}