import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web300_socialgo/Authentication/Pages/Login.dart';
// import 'package:web300_socialgo/Authentication/Pages/SignUp.dart';

import 'package:web300_socialgo/webapp/app.dart';


class wraper extends StatefulWidget{

  State<wraper> createState()=> _wraperClass();

}
class _wraperClass extends State<wraper> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
      if(snapshot.hasData){
        return MainLayout() ;
      }
      else{
        return LoginPage();
      }
    }),
  );
  }
}