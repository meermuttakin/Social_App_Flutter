import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _formKey = GlobalKey<FormState>();

  Submit(){
    _formKey.currentState.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext parentContext) {
    return new Scaffold(
      appBar: header(context, titleText: "Set Up a Profile"),
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
                        child: TextFormField(
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
