import 'package:cloth_material_chat_app/pages/individualRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class mainRegisterPage extends StatelessWidget {
  static String route = "/mainRegistration";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
/*
    return PlayAnimationBuilder<Color?>(
        // <-- animate integers
        tween: ColorTween(begin: Colors.red, end: Colors.blue), // define tween
        duration: const Duration(seconds: 5),
        builder: (_, Color? color, value) {*/
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15), //apply padding to all four sides
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size.fromHeight(50))),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => individualRegister(),
                      transitionDuration: Duration(seconds: 1),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  );
                },
                child: Text(
                  'Individual Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(15), //apply padding to all four sides
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size.fromHeight(50))),
                onPressed: () {},
                child: Text(
                  'Yarn Mills Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ),
        ],
      ),
    ));
    //  });
  }
}
