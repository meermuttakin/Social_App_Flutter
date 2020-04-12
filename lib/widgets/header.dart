import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText, removeBackButton = false}) {
  return new AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: new Text(
      isAppTitle ? 'Social App' : titleText,
      style: new TextStyle(
        fontFamily: isAppTitle ? "Signatra" : " ",
        fontSize: isAppTitle ? 50.0 : 22.0,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
