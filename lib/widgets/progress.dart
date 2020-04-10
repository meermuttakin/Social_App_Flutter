import 'package:flutter/material.dart';

Container circularProgress() {
  return new Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

Container linearProgress() {
  return new Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.orange),
    ),
  );
}
