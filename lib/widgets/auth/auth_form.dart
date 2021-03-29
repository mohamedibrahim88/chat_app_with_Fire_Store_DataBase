import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final void Function(String email, String username, String password,
      File image, bool isLogin, BuildContext ctx) submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _username = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('please upload image')));
      return;
    }

    if (_isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _username.trim(), _userPassword.trim(),
          _userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  //email
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  //username
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'please enter at least 4 character';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  //password
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: trySubmit,
                      child: Text(_isLogin ? 'LogIn' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create new Account'
                            : 'I already have an account')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
