import 'package:flutter/material.dart';
import 'package:jute/webBrain.dart';

Color menuTextColor = const Color(0xffC9C9C9);
Color selectedModelColor = Colors.blue;
Color unSelectedModelColor = const Color(0xff1E1E1E);
Color appBarColor = const Color(0xff010A19);

ImageProvider backGroundImage = const AssetImage("images/background.png");

class ResultPage extends StatefulWidget {
  final dynamic apiResult;
  final dynamic image;

  const ResultPage({Key? key, required this.apiResult, required this.image})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool menu = true;

  int selectedModel = 1;
  bool selectAll = true;

  Map<String, List> allBoxes = {};
  List<Widget> visibleBoxes = [];

  void drawBoxes() {
    // visibleBoxes.clear();
    for (int i = 0; i < 8; i++) {
      if (diseasesMenu[i]) {
        visibleBoxes.addAll(allBoxes[modelsName[selectedModel - 1]]![i]);
      }
    }
    setState(() {
      visibleBoxes;
    });
  }

  List<Widget> diseasesMenuBuilder() {
    List<Widget> lst = [
      Center(
        child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        side: const BorderSide(color: Color(0xff5A5A5A)),
                        value: selectAll,
                        onChanged: (dynamic value) {
                          setState(() {
                            selectAll = value;
                            for (var i = 0; i < diseasesMenu.length; i++) {
                              diseasesMenu[i] = value;
                            }
                          });
                        }),
                    Text(
                      'All',
                      style: TextStyle(
                          color: menuTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Diseases List",
                  style: TextStyle(
                      color: menuTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        menu = !menu;
                      });
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ))
              ],
            )),
      )
    ];
    for (var i = 0; i < diseasesList.length; i++) {
      lst.add(
        CheckBox(
          value: diseasesMenu[i],
          onChange: (dynamic value) {
            setState(() {
              diseasesMenu[i] = value;
            });
          },
          color: diseasesListColors[i],
          label: diseasesList[i],
        ),
      );
    }
    return lst;
  }

  List<Widget> modelsMenuBuilder() {
    List<Widget> lst = [
      Center(
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
    ];
    for (var i = 1; i <= modelsName.length; i++) {
      lst.add(
        ModelButton(
          onTap: () {
            setState(() {
              selectedModel = i;
            });
          },
          isSelected: selectedModel == i,
          buttonLabel: "model $i",
        ),
      );
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    allBoxes = boxesBuilder(context, widget.apiResult);

    // screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // // image dimensions
    double width = screenWidth / 2.5;
    double height = screenHeight / 1.5;

    double widthBias = (screenWidth - width) / 2;
    double heightBias = (screenHeight - height) / 2;

    visibleBoxes = [
      Container(),
      Positioned(
        left: widthBias - width / 4,
        top: heightBias - height / 9,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff121214),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          height: height / 9,
          width: width + width / 4,
          child: Center(
            child: Text(
              "Model $selectedModel",
              style: TextStyle(color: menuTextColor, fontSize: 25),
            ),
          ),
        ),
      ),
      Positioned(
        left: widthBias - width / 4,
        top: heightBias,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff121214),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))),
          width: width / 4,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListView(children: modelsMenuBuilder()),
          ),
        ),
      ),
      Positioned(
        left: widthBias,
        top: heightBias,
        child: ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(8)),
          child: Image.memory(
            widget.image,
            fit: BoxFit.fill,
            width: width,
            height: height,
          ),
        ),
      ),
      Positioned(
        left: (widthBias + width - width / 8) + (width / 3),
        top: heightBias - height / 18,
        child: GestureDetector(
          onTap: () {
            setState(() {
              menu = !menu;
            });
          },
          child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Color(0xff121214),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Icon(
                Icons.menu,
                size: 25,
                color: menuTextColor,
              )),
        ),
      ),
      Positioned(
        left: screenWidth / 2 - 100,
        top: heightBias + height,
        child: InkWell(
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: selectedModelColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Try another Image',
                        style: TextStyle(color: menuTextColor),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ];

    drawBoxes();

    visibleBoxes.add(Visibility(
      visible: menu,
      child: Positioned(
        left: widthBias + width - width / 8,
        top: heightBias - height / 18,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff121214),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          width: width / 2.5,
          height: height - height / 10,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListView(
              controller: ScrollController(),
              children: diseasesMenuBuilder(),
            ),
          ),
        ),
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage("images/logo.png"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Teeth Vision"),
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backGroundImage,
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Stack(fit: StackFit.expand, children: visibleBoxes),
      ),
    );
  }
}

class ModelButton extends StatelessWidget {
  const ModelButton(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.buttonLabel})
      : super(key: key);

  final Function() onTap;
  final bool isSelected;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? selectedModelColor : unSelectedModelColor,
            border: Border.all(color: const Color(0xff5A5A5A)),
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

class CheckBox extends StatefulWidget {
  final Color color;
  final bool value;
  final void Function(dynamic value) onChange;
  final String label;

  const CheckBox(
      {Key? key,
      required this.color,
      required this.value,
      required this.onChange,
      required this.label})
      : super(key: key);

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff1E1E1E),
          border: Border.all(color: const Color(0xff5A5A5A))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
                fillColor: MaterialStateProperty.resolveWith((Set states) {
                  return widget.color;
                }),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                side: const BorderSide(color: Color(0xff5A5A5A)),
                value: widget.value,
                onChanged: widget.onChange),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.label,
                style: TextStyle(color: menuTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
