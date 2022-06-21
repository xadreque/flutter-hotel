import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';
import 'login.dart';

class PostForm extends StatefulWidget {
  // PostForm({Key? key}) : super(key: key);
  final Post? post;
  final String? title;

  // ignore: use_key_in_widget_constructors
  const PostForm({this.post, this.title});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  //_____++=+++++++++==+VALIDACAO _______-------------=

  //Validacao do Formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //loading progressBar
  bool _loading = false;

  //Para a validacao dos Campos
  TextEditingController textControllerBody = TextEditingController();

  //--------====][]]]]]]]]]][]]]]]]]]]]]]]]][[-----------------]]

//================ IMPLEMENTANDO IMAGE DATA PIKER ========

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

//***************** CREATE POST  */

  void _createPost() async {
    String? image = _imageFile == null ? null : getStringImage(_imageFile!);
    ApiResponse response = await createPost(textControllerBody.text, image);
    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then(
        (value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
      setState(() {
        _loading = !_loading;
      });
    }
  }

//***************** Edit POST  */

  void _editPost(int postId) async {
    ApiResponse response = await editPost(postId, textControllerBody.text);
    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then(
        (value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  //Inicializando o Edit
  @override
  void initState() {
    if (widget.post != null) {
      textControllerBody.text = widget.post!.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add"),
      ),
      body:
          //---------=+++++++++++ progressBar-------- ou loading()
          _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    //Edit
                    widget.post != null
                        ? SizedBox()
                        : Container(
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
                    Form(
                      //-------_+{}}{} Validando Formulario [[]]]]]]]]]]]
                      key: formKey,
                      //[[]]]]]][]][][[[[][]]]]
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextFormField(
                          ////8**************** VALIDANDO O CAMPO BODY +++++++=+
                          controller: textControllerBody,

                          //campo-
                          validator: (val) =>
                              val!.isEmpty ? "Post Body Is Required" : null,
                          decoration: InputDecoration(
                            hintText: "Post Body.....",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black38),
                            ),
                          ),
                        ),
                        
                      ),
                     
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: globalTextButton(
                        'Post',
                        () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              _loading = !_loading;
                            });
                            //condicionando a abertura do formulario para editar ou adicionar
                            if (widget.post == null) {
                              _createPost();
                            } else {
                              _editPost(widget.post!.id ?? 0);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
