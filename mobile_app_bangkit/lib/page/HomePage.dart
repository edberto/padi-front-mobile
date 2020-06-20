import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './category_card.dart';
import '../Screens/Welcome/welcome_screen.dart';
import './ML/plant_detection.dart';
import './ML2/plant_detector.dart';
import './QnA/chatbox.dart';
import 'package:mobile_app_bangkit/page/form.dart';
import '../models/main.dart';

class HomeScreen extends StatefulWidget {
  final MainModel model;

  HomeScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                // Here the height of the container is 45% of our total height
                height: size.height * .45,
                decoration: BoxDecoration(
                  color: Colors.green[300], //Color(0xFF9CCC65)
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.of(context).pushNamed('/chatbox');
                      //       print("Tap tap");
                      //     },
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       height: 52,
                      //       width: 52,
                      //       decoration: BoxDecoration(
                      //         color: Color(0xFFF1F8E9),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: SvgPicture.asset("assets/icons/question.svg"),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Text(
                        "Hello, ${widget.model.user.id} !",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text('it\'s AI time !'),
                      // SearchBar(),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: <Widget>[
                            CategoryCard(
                              title: "Leaf Detector",
                              svgSrc: "assets/icons/leaf.svg",
                              press: () {
                                Navigator.of(context).pushNamed('/ML2');
                              },
                            ),
                            CategoryCard(
                              title: "History",
                              svgSrc: "assets/icons/doctor.svg",
                              press: () {
                                Navigator.of(context)
                                    .pushNamed('/product_list');
                              },
                            ),
                            CategoryCard(
                              title: "QnA",
                              svgSrc: "assets/icons/question.svg",
                              press: () {
                                // print(widget.model.allProducts.length);
                                Navigator.of(context).pushNamed('/chatbox');
                              },
                            ),
                            CategoryCard(
                              title: "Log out",
                              svgSrc: "assets/icons/exit.svg",
                              press: () {
                                Navigator.of(context).pushReplacementNamed('/');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: () async => false);
  }
}
