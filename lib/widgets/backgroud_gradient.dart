import 'package:flutter/material.dart';

class BackGroundGradient extends StatelessWidget {
  const BackGroundGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.red],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(2.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
      ),
    );
  }
}
