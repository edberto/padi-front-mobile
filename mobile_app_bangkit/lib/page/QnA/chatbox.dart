import 'package:flutter/material.dart';
import './bubble.dart';
import 'package:flutter_svg/svg.dart';

class Chatbox extends StatefulWidget {
  // Chatbox({Key key}) : super(key: key);

  @override
  _ChatboxState createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;
    var size = MediaQuery.of(context).size;
    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Container(
      color: Colors.green[300],
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              // decoration: BoxDecoration(
              //   color: Color(0xFFF1F8E9),
              //   shape: BoxShape.circle,
              // ),
              child: SvgPicture.asset("assets/icons/question.svg"),
            ),
          ),
          
          SizedBox(
            height: size.height * 0.05,
          ),
          Bubble(
            style: styleSomebody,
            child: Text(
                'What is the use of PADI application?',
                style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            child: Text('This application is embedded with artificial intelligence that can help to detect the condition of rice plants', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleSomebody,
            child: Text('How to use this app?',
                style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            child: Text('You can take the leaf image from your galerry or camera', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleSomebody,
            margin: BubbleEdges.only(top: 2.0),
            nip: BubbleNip.no,
            child: Text('Is this application paid?', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            nip: BubbleNip.no,
            margin: BubbleEdges.only(top: 2.0),
            child: Text('No, It is totally free !', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleSomebody,
            margin: BubbleEdges.only(top: 2.0),
            nip: BubbleNip.no,
            child: Text('Does the AI depend on internet connection?', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            nip: BubbleNip.no,
            margin: BubbleEdges.only(top: 2.0),
            child: Text('No, you can use it without internet connection for clasify your image', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
