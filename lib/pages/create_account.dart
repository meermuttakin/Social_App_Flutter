import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Submit(){
    final form = _formKey.currentState;
    if (form.validate()){
      form.save();
      SnackBar snackBar = SnackBar(content: Text("Welcome $username"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }

  }

  @override
  Widget build(BuildContext parentContext) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: header(context, titleText: "Set Up a Profile", removeBackButton: true),
      body: new ListView(
        children: <Widget>[
          new Container(
            child: new Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: new Text('CREATE A USERNAME',
                  style: new TextStyle(
                    fontSize: 25.0,
                  ),),
                ),),
                Padding(padding: EdgeInsets.all(16.0),
                  child: new Container(
                    child: Form(
                      key: _formKey,
                        autovalidate: true,
                        child: TextFormField(
                          validator: (val) {
                            if(val.trim().length < 3 || val.isEmpty){
                              return "Username Is Too Short";
                            }else if(val.trim().length > 12){
                              return "Username Is Too Long";
                            }else{
                              return null;
                            }
                          },
                          onSaved: (val) => username = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "USERNAME",
                            labelStyle: TextStyle(fontSize: 15.0),
                            hintText: "Must be at least three characteristics"
                          ),
                        ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: Submit,
                  child: new Container(
                    height: 50.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(child : new Text('SUBMIT',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
