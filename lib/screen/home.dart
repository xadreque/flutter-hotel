import 'package:busness_in_touch/screen/empreendedora_screen.dart';
import 'package:busness_in_touch/screen/postForm.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../services/user_service.dart';
import 'login.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Emprendendoras'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout().then(
                (value) => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false),
              );
            },
          )
        ],
      ),
      //Essa maneira e para o change do person e home + no mesmo container ou formulario
      body: currentIndex == 0 ? Empreendedora() : Profile(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

/*
//Chamamento do formulario PostForm
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PostForm(
                title: 'Add New Post',
              )),);
        */
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
          currentIndex: currentIndex,
          onTap: (val) {
            setState(() {
              currentIndex = val;
            });
          },
        ),
      ),
    );
  }
}

/**
 * 
 * 
 * body: Center(
        child: GestureDetector(
          onTap:() => 
          child: Text('Home: Press to logout'),
        ),
       
      ),
 */
