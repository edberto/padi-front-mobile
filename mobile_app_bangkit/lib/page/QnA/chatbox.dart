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
                'Apa kegunaan aplikasi PADI?',
                style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            child: Text('Aplikasi ini digunakan untuk mengetahui kondisi tanaman padi dengan bantuan kecerdasan buatan', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleSomebody,
            child: Text('Bagaimana cara menggunakan aplikasi ini?',
                style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            child: Text('Kamu bisa memilih gambar dari kamera atau galeri dan melakukan pendeksian cepat.', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleSomebody,
            margin: BubbleEdges.only(top: 2.0),
            nip: BubbleNip.no,
            child: Text('Apakah aplikasi ini berbayar?', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            nip: BubbleNip.no,
            margin: BubbleEdges.only(top: 2.0),
            child: Text('Tidak, ini sepenuhnya gratis !', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleSomebody,
            margin: BubbleEdges.only(top: 2.0),
            nip: BubbleNip.no,
            child: Text('Apakah memerlukan koneksi internet?', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          Bubble(
            style: styleMe,
            nip: BubbleNip.no,
            margin: BubbleEdges.only(top: 2.0),
            child: Text('Ya, karena riwayat pendeksian akan disimpan di server yang aman', style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
