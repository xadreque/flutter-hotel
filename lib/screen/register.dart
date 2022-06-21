//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //combo
  List<dynamic> typeColect = [];
  String? typeId;

  @override
  void initState() {
    super.initState();
    this.typeColect.add({"id": 1, "name": "Entrepernuer"});
    this.typeColect.add({"id": 2, "name": "Single"});
    this.typeColect.add({"id": 3, "name": "Provider"});
    this.typeColect.add({"id": 4, "name": "Other"});
  }

  //Validacao do Formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //loading progressBar
  bool loading = false;

  //Para a validacao dos Campos
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmationController = TextEditingController();

  ///===-===++Metodo que register Ususario=======

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text,typeId.toString());
    if (response.error == null) {
      _saveAndRedirectToken(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${response.error}',
          ),
        ),
      );
    }
  }

// Save And redirect to Home
  void _saveAndRedirectToken(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('user_id', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

//final
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          children: [
            TextFormField(
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Invalide Name' : null,
              decoration: globalInputDecoration('Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Invalide Email' : null,
              decoration: globalInputDecoration('Email'),
            ),
            SizedBox(
              height: 20,
            ),
            FormHelper.dropDownWidget(
                context, "Select Type",
                 this.typeId, this.typeColect,
                (onChangedVal) {
              this.typeId = onChangedVal;
              print("Selected Type: $onChangedVal");
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return "Please Select Type";
              }
              return null;
            },
            borderColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            optionValue: "id",
            optionLabel: "name",
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (val) => val!.isEmpty ? 'Invalide Password' : null,
              decoration: globalInputDecoration('Password'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordConfirmationController,
              obscureText: true,
              validator: (val) =>
                  val!.isEmpty ? 'Confirm password does not match' : null,
              decoration: globalInputDecoration('Passwod Confirmation'),
            ),
            SizedBox(
              height: 20,
            ),
            loading
                ? Center(child: CircularProgressIndicator())
                : globalTextButton(
                    'Register',
                    () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _registerUser();
                        });
                      }
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            glabalMessageLink('Already have an account?', 'Login', () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            }),
          ],
        ),
      ),
    );
  }
}
