import 'package:flutter/material.dart';


class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -20,
            right: -70,
            child: Image.asset('assets/images/sun.png'),
            width: size.width*0.5,
          ),
          Positioned(
            bottom: -10,
            left: 0,
            child: Image.asset('assets/images/forest.png'),
            width: size.width*0.4,
          ),
          Positioned(
            bottom: -10,
            right: 0,
            child: Image.asset('assets/images/forest.png'),
            width: size.width*0.4,
          ),
          child
        ],
      ),
    );
  }
}