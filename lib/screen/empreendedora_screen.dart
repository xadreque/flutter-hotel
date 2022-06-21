import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../constant.dart';
import 'login.dart';

class Empreendedora extends StatefulWidget {
  const Empreendedora({Key? key}) : super(key: key);

  @override
  State<Empreendedora> createState() => _EmpreendedoraState();
}

class _EmpreendedoraState extends State<Empreendedora> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

   //combo
  List<dynamic> servicesColect = [];
  String? serviceId;

  @override
  void initState() {
    super.initState();
    this.servicesColect.add({"id": 1, "name": "Cathering"});
    this.servicesColect.add({"id": 2, "name": "Restaurant"});
    this.servicesColect.add({"id": 3, "name": "Hosting"});
    this.servicesColect.add({"id": 4, "name": "Even Planner"});
  }
  //Para a validacao dos Campos
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmationController = TextEditingController();
  //================ IMPLEMENTANDO IMAGE DATA PIKER ========
//DateTime? newDate= await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1900), lastDate: DateTime(2200),);
  DateTime date = DateTime(2022, 12, 24);
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    //A imagem pode ser buscada a partir da camera usando final pickerFile = await _picker.getImage(source: ImageSource.camera);
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
//================ *********************** ========

  //loading progressBar
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Add'),
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
            FormHelper.dropDownWidget(
                context, "Select Service",
                 this.serviceId, this.servicesColect,
                (onChangedVal) {
              this.serviceId = onChangedVal;
              print("Selected Type: $onChangedVal");
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return "Please Select Service";
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
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              //*********** MOSTRANDO A IMAGEM */
              decoration: BoxDecoration(
                image: _imageFile == null
                    ? null
                    : DecorationImage(
                        image: FileImage(_imageFile ?? File('')),
                        fit: BoxFit.cover),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.black38,
                  ),
                  onPressed: () {
                    /////////************* Capturando a Iamgaem ******** */
                    getImage();
                  },
                ),
              ),
            ),
            TextFormField(
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Location is required' : null,
              decoration: globalInputDecoration('Location'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Invalide address' : null,
              decoration: globalInputDecoration('Address'),
            ),
            /*Text(
              '${date.year}/${date.month}/${date.day}',
              style: TextStyle(fontSize: 12),
            ),*/
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if 'Cancel'=> null
                  if (newDate == null) return;
                  //if 'Ok' => DateTime
                  setState(() => date=newDate);
                },
                child: Text("Select Initial Date Activity ")),
            SizedBox(
              height: 20,
            ),
          
              Text('${date.year}/${date.month}/${date.day}', style: TextStyle(color: Colors.brown),)
            
              //decoration: globalInputDecoration('Date Initial Service'),
            ,
            SizedBox(
              height: 20,
            ),
            loading
                ? Center(child: CircularProgressIndicator())
                : globalTextButton(
                    'Post ',
                    () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          // _registerUser();
                        });
                      }
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            /*
           
            glabalMessageLink('Already have an account?', 'Login', () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            }),*/
          ],
        ),
      ),
    );
  }
}
