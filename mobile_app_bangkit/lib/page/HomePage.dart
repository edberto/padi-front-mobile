import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './category_card.dart';
import '../Screens/Welcome/welcome_screen.dart';
import './ML/plant_detection.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF9CCC65),              
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushReplacementNamed('/');
                        print("Tap tap");
                      },
                      child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F8E9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/question.svg"),
                    ),
                    ),
                  ),
                  Text(
                    "How is your day?",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  // SearchBar(),
                  SizedBox(height: size.height*0.1,),
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
                            print("HAHAHAH");
                            Navigator.of(context).pushNamed('/ML');
                          },
                        ),
                        CategoryCard(
                          title: "Create Form",
                          svgSrc: "assets/icons/vegetable.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "History",
                          svgSrc: "assets/icons/doctor.svg",
                          press: () {},
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
    );
  }
}
