import 'package:busness_in_touch/screen/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';

class Login extends StatefulWidget {
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
//Loading ProgressBAr

  bool loading = false;

  //------->>>>>>><<<<<<>>>>> Form Controll <<>>>><<>><<>>----
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

//+++_=++++=++++ Text email <><>>><><>>>><<>><>>>>
  TextEditingController textEmail = TextEditingController();

//+++_=++++=++++ Text password <><>>><><>>>><<>><>>>>
  TextEditingController textpassword = TextEditingController();

  // private method to login

  void _loginUser() async {
    ApiResponse response = await login(textEmail.text, textpassword.text);
    if (response.error == null) {
      _userAndRedirectToken(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

//UserAndRedirectToken // Destrucao do token
  void _userAndRedirectToken(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('user_id', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(12),
            children: [
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: textEmail,
                  validator: (val) =>
                      val!.isEmpty ? 'Invalid email address ' : null,
                  decoration: globalInputDecoration('Email')),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                //keyboardType: TextInputType.emailAddress
                obscureText: true,
                controller: textpassword,
                validator: 
                 (val) => val!.length <6
                    ? 'The password must be at least 6 Characters!'
                    : null,
                decoration: globalInputDecoration('Password'),
              ),
              SizedBox(
                height: 10,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : globalTextButton('Login', () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _loginUser();
                        });
                      }
                    }),
              SizedBox(
                height: 10,
              ),
              glabalMessageLink('Dont you have an account? ', 'Register', () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Register()),
                    (route) => false);
              }),
            ],
          )),
    );
  }
}
