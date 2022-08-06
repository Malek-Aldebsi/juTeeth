import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:jute/sliderButton.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:jute/test.dart';

import 'new.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FstPage(),
    );
  }
}

class FstPage extends StatefulWidget {
  const FstPage({Key? key}) : super(key: key);

  @override
  State<FstPage> createState() => _FstPageState();
}

class _FstPageState extends State<FstPage> {
  bool imageAvailable = false;

  dynamic imageFile;
  String imageName = "No file chosen";
  String submit = "Submit";

  String isCaries = "False";
  String isPL = "False";
  String isRCT = "False";
  String isFRCNN = "False";
  String isAtrous = "False";

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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/img1.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  constraints: BoxConstraints(
                    maxWidth: 800.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Upload Photo",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("Photo",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  constraints: BoxConstraints(
                                    minHeight: 38.0,
                                    maxHeight: 38.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffDDE0E3)),
                                    color: Color(0xffDDE0E3),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3.0),
                                      bottomLeft: Radius.circular(3.0),
                                    ),
                                  ),
                                  child: MaterialButton(
                                    focusColor: Color(0xffC9CCCF),
                                    onPressed: () async {
                                      final image = await ImagePickerWeb
                                          .getImageAsBytes();

                                      setState(() {
                                        imageFile = image!;
                                        imageName = "image.png";
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Choose File",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            Expanded(
                              flex: 3,
                              child: Container(
                                constraints: BoxConstraints(
                                  minHeight: 38.0,
                                  maxHeight: 38.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(3.0),
                                    bottomRight: Radius.circular(3.0),
                                  ),
                                  border: Border.all(
                                    color: Color(0xffDDE0E3),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      imageName,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5.0),
                          child: Row(
                            children: [
                              SliderButton(
                                onPress: () {
                                  setState(() {
                                    isFRCNN == "False"
                                        ? isFRCNN = "True"
                                        : isFRCNN = "False";
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text("Faster RCNN (All classes)"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              SliderButton(
                                onPress: () {
                                  isAtrous == "False"
                                      ? isAtrous = "True"
                                      : isAtrous = "False";
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text("Atrous (All classes)"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              SliderButton(
                                onPress: () {
                                  setState(() {
                                    isCaries == "False"
                                        ? isCaries = "True"
                                        : isCaries = "False";
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text("Caries"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              SliderButton(
                                onPress: () {
                                  setState(() {
                                    isPL == "False"
                                        ? isPL = "True"
                                        : isPL = "False";
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text("PL"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              SliderButton(
                                onPress: () {
                                  setState(() {
                                    isRCT == "False"
                                        ? isRCT = "True"
                                        : isRCT = "False";
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text("RCT"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              onPressed: () async {
                                setState(() {
                                  submit = "loading";
                                });
                                var request = http.MultipartRequest(
                                    'POST',
                                    Uri.parse(
                                        'http://juteeth.pythonanywhere.com/api/upload'));
                                request.files.add(http.MultipartFile.fromBytes(
                                    'image', imageFile,
                                    filename: 'img1.png',
                                    contentType:
                                        new MediaType('image', 'png')));
                                request.fields['caries'] = isCaries;
                                request.fields['pl'] = isPL;
                                request.fields['rct'] = isRCT;
                                request.fields['frcnn'] = isFRCNN;
                                request.fields['atrous'] = isAtrous;
                                var response = await request.send();

                                dynamic resultDict;

                                if (response.statusCode == 200) {
                                  resultDict = jsonDecode(
                                      await response.stream.bytesToString());
                                }
                                print(resultDict);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => neww(
                                              image: imageFile,
                                              boxes: resultDict,
                                            )));
                              },
                              child: Text(
                                submit,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(50.0),
              //   child: Container(
              //       constraints:
              //           BoxConstraints(maxWidth: 800.0, maxHeight: 800.0),
              //       child: imageAvailable
              //           ? Image.memory(
              //               imageFile,
              //               alignment: Alignment.topCenter,
              //             )
              //           : SizedBox()),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
