import 'package:flutter/material.dart';
import 'package:jute/sliderButton.dart';

// main method
void main() {
// runapp method run the our main app
  runApp(SimpleAppBarPopupMenuButton());
}

class SimpleAppBarPopupMenuButton extends StatefulWidget {
  const SimpleAppBarPopupMenuButton({Key? key}) : super(key: key);

  @override
  State<SimpleAppBarPopupMenuButton> createState() =>
      _SimpleAppBarPopupMenuButtonState();
}

class _SimpleAppBarPopupMenuButtonState
    extends State<SimpleAppBarPopupMenuButton> {
  bool menu = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // scaffold with appbar
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Container(),
              Visibility(
                visible: menu,
                child: Positioned(
                  left: 50,
                  top: 50,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: 300,
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Caries",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "recurrent caries (RC)",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "remaining root (RR)",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "root canal treatment (RCT)",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "overhang restoration (OR)",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "periapical Lesion (PL)",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "URCT",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Crown",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SliderButton(
                                  onPress: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      menu = !menu;
                    });
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(
                        Icons.menu,
                        size: 25,
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
