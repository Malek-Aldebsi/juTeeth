import 'package:flutter/material.dart';
import 'package:jute/sliderButton.dart';

void main() {
  runApp(const MyApp());
}

Color menuTextColor = Color(0xffC9C9C9);
Color selectedModelColor = Colors.blue;
Color unSelectedModelColor = Color(0xff1E1E1E);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: neww(),
    );
  }
}

class neww extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff010A19),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image(
                  height: 40,
                  width: 40,
                  image: AssetImage("images/logo.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Denta Vision"),
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/img1.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: DrawBoxes(),
      ),
    );
  }
}

class DrawBoxes extends StatefulWidget {
  const DrawBoxes({Key? key}) : super(key: key);

  @override
  State<DrawBoxes> createState() => _DrawBoxesState();
}

class _DrawBoxesState extends State<DrawBoxes> {
  int round = 0;
  bool menu = true;

  int selectedModel = 0;

  dynamic menuList = [false, false, false, false, false, false, false, false];

  double width = 1000 * 65 / 100 as double;
  double height = 720 * 65 / 100 as double;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double widthBias = (screenWidth - width) / 2;
    double heightBias = (screenHeight - height) / 2;

    return Stack(children: [
      Container(),
      Positioned(
        left: width / 2 - 10,
        top: heightBias - 69,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff121214),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          height: 50,
          width: width + 116,
          child: Center(
            child: Text(
              "Model 2",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
      Positioned(
        left: width / 2 - 10,
        top: heightBias - 20,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff121214),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))),
          width: 140,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListView(
              children: [
                Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Choose model",
                        style: TextStyle(
                            color: menuTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ModelButton(
                  onTap: () {
                    setState(() {
                      selectedModel = 1;
                      print(1);
                    });
                  },
                  isSelected: selectedModel == 1,
                  buttonLabel: "model 1",
                ),
                ModelButton(
                  onTap: () {
                    setState(() {
                      selectedModel = 2;
                    });
                  },
                  isSelected: selectedModel == 2,
                  buttonLabel: "model 2",
                ),
                ModelButton(
                  onTap: () {
                    setState(() {
                      selectedModel = 3;
                    });
                  },
                  isSelected: selectedModel == 3,
                  buttonLabel: "model 3",
                ),
                ModelButton(
                  onTap: () {
                    setState(() {
                      selectedModel = 4;
                    });
                  },
                  isSelected: selectedModel == 4,
                  buttonLabel: "model 4",
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: widthBias,
        top: heightBias - 20,
        child: ClipRRect(
          child: Image(
            image: AssetImage("images/t2.jpg"),
            width: width,
            height: height,
          ),
        ),
      ),
      Positioned(
        left: widthBias + width / 4,
        top: heightBias + height + 10,
        child: Row(
          children: [
            ArrowButton(
                icon: Icons.keyboard_arrow_left,
                onTap: () {
                  setState(() {
                    round = (round - 1) % 4;
                  });
                }),
            IndexCircle(
              isSelected: round == 0,
            ),
            IndexCircle(
              isSelected: round == 1,
            ),
            IndexCircle(
              isSelected: round == 2,
            ),
            IndexCircle(
              isSelected: round == 3,
            ),
            ArrowButton(
                icon: Icons.keyboard_arrow_right,
                onTap: () {
                  setState(() {
                    round = (round + 1) % 4;
                  });
                })
          ],
        ),
      ),
      Visibility(
        visible: menu,
        child: Positioned(
          left: ((widthBias * 2 + width) / 2) + width / 4 + 100,
          top: heightBias - 40,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xff121214),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: 300,
            height: 415,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Diseases List",
                          style: TextStyle(
                              color: menuTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              side: BorderSide(color: Color(0xff5A5A5A)),
                              value: menuList[0],
                              onChanged: (dynamic value) {
                                setState(() {
                                  menuList[0] = value;
                                });
                              }),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Caries",
                              style: TextStyle(color: menuTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              side: BorderSide(color: Color(0xff5A5A5A)),
                              value: menuList[1],
                              onChanged: (dynamic value) {
                                setState(() {
                                  menuList[1] = value;
                                });
                              }),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "recurrent caries (RC)",
                              style: TextStyle(color: menuTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "remaining root (RR)",
                              style: TextStyle(color: menuTextColor),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "root canal treatment (RCT)",
                              style: TextStyle(color: menuTextColor),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "overhang restoration (OR)",
                              style: TextStyle(color: menuTextColor),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "periapical Lesion (PL)",
                              style: TextStyle(color: menuTextColor),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "URCT",
                              style: TextStyle(color: menuTextColor),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        border: Border.all(color: Color(0xff5A5A5A)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Crown",
                              style: TextStyle(color: menuTextColor),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 40,
        top: 30,
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
      Visibility(
        visible: round == 1,
        child: Positioned(
          child: Container(
            color: Colors.amber,
            height: 20,
            width: 50,
          ),
        ),
      ),
      Visibility(
        visible: round == 2,
        child: Positioned(
          child: Container(
            color: Colors.red,
            height: 20,
            width: 50,
          ),
        ),
      ),
    ]);
  }
}

class IndexCircle extends StatelessWidget {
  IndexCircle({
    required this.isSelected,
  });

  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        width: 15,
        height: 15,
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  ArrowButton({
    required this.icon,
    required this.onTap,
  });

  IconData icon;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 35,
      ),
      color: Colors.white,
    );
  }
}

class ModelButton extends StatelessWidget {
  ModelButton(
      {required this.onTap,
      required this.isSelected,
      required this.buttonLabel});

  Function() onTap;
  bool isSelected;
  String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? selectedModelColor : unSelectedModelColor,
            border: Border.all(color: Color(0xff5A5A5A)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Text(
                  buttonLabel,
                  style: TextStyle(color: menuTextColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
