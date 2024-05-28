import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("images/login.jpg"),
            ))
          ],
        )
      ],
    );
  }
}
