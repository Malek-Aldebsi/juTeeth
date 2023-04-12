import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jute/teeeeeest.dart';
import 'package:jute/DropZoneWidget.dart';
import 'package:jute/uploadImage/file_DataModel.dart';
import 'globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FstPage(),
    );
  }
}

class FstPage extends StatefulWidget {
  const FstPage({Key? key}) : super(key: key);

  @override
  State<FstPage> createState() => _FstPageState();
}

class _FstPageState extends State<FstPage> {
  File_Data_Model? file;
  dynamic resultDict = {'v8': [], 'v9': [], 'yolo': [], 'ensemble': []};
  dynamic v8ResultDict;
  dynamic v9ResultDict;
  dynamic yoloResultDict;
  dynamic ensembleResultDict;
  bool visible = false;
  dynamic img8List;
  List end = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff010A19),
      //   title: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //     child: Row(
      //       children: [
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(25.0),
      //           child: const Image(
      //             height: 75,
      //             width: 75,
      //             image: AssetImage("images/logo.png"),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      // Container(
                      //   color: Color(0xffDCE2F0),
                      //   height: screenHeight * 0.08,
                      //   width: screenWidth,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       InkWell(
                      //         child: Container(
                      //           height: screenHeight * 0.04,
                      //           width: screenWidth * 0.08,
                      //           decoration: BoxDecoration(
                      //               border: Border.all(color: Colors.black),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(screenWidth * 0.005))),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: screenWidth * 0.02,
                      //       ),
                      //       InkWell(
                      //         child: Container(
                      //           height: screenHeight * 0.04,
                      //           width: screenWidth * 0.08,
                      //           decoration: BoxDecoration(
                      //               border: Border.all(color: Colors.black),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(screenWidth * 0.005))),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: screenWidth * 0.02,
                      //       ),
                      //       InkWell(
                      //         child: Container(
                      //           height: screenHeight * 0.04,
                      //           width: screenWidth * 0.08,
                      //           decoration: BoxDecoration(
                      //               border: Border.all(color: Colors.black),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(screenWidth * 0.005))),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: screenWidth * 0.02,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: screenHeight / 15),
                      Image(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage("images/1.png"),
                        height: screenHeight / 3.5,
                        color: Color(0xffDCE2F0),
                        width: screenWidth / 3,
                      ),
                      SizedBox(height: screenHeight / 25),
                      Container(
                        height: screenHeight / 2,
                        width: screenWidth / 2,
                        child: DropZoneWidget(
                          onDroppedFile: (file) async {
                            setState(() => this.file = file);

                            http.Response img = await http.get(
                              Uri.parse(file.url),
                            );

                            setState(() {
                              visible = true;
                            });

                            Map<String, List> ensembleDict = {
                              'boxes': [[], [], []],
                              'scores': [[], [], []],
                              'classes': [[], [], []],
                              'weights': [1, 1, 1]
                            };

                            img8List = await img.bodyBytes;

                            var imgRequest = http.MultipartRequest(
                                'POST',
                                Uri.parse(
                                    'https://lobster-app-r8jem.ondigitalocean.app/upload/'));
                            imgRequest.files.add(http.MultipartFile.fromBytes(
                                'image', img8List,
                                filename: globals.name,
                                contentType: new MediaType('image', 'png')));
                            imgRequest.headers['Content-Type'] =
                                'application/json; charset=UTF-8';
                            var imgResponse = await imgRequest.send();
                            dynamic orentation = await jsonDecode(
                                await imgResponse.stream.bytesToString());
                            print(await orentation);

                            setState(() {
                              end[0] = true;
                            });

                            var v8Response = await http.post(
                                Uri.parse(
                                    'https://lobster-app-r8jem.ondigitalocean.app/v8/'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8'
                                },
                                body: jsonEncode(
                                  <String, String>{'filename': globals.name},
                                ));

                            if (v8Response.statusCode == 200) {
                              v8ResultDict =
                                  await jsonDecode(await v8Response.body);
                              resultDict['v8'] = v8ResultDict;
                              for (Map box in v8ResultDict) {
                                ensembleDict['boxes']![0].add(box['box']);
                                ensembleDict['scores']![0].add(box['score']);
                                ensembleDict['classes']![0].add(box['cls']);
                              }
                            }
                            setState(() {
                              end[1] = true;
                            });

                            var v9Response = await http.post(
                                Uri.parse(
                                    'https://lobster-app-r8jem.ondigitalocean.app/v9/'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8'
                                },
                                body: jsonEncode(
                                  <String, String>{'filename': globals.name},
                                ));

                            if (v9Response.statusCode == 200) {
                              v9ResultDict =
                                  await jsonDecode(await v9Response.body);
                              resultDict['v9'] = v9ResultDict;
                              for (Map box in v9ResultDict) {
                                ensembleDict['boxes']![1].add(box['box']);
                                ensembleDict['scores']![1].add(box['score']);
                                ensembleDict['classes']![1].add(box['cls']);
                              }
                            }
                            setState(() {
                              end[2] = true;
                            });

                            var yoloResponse = await http.post(
                                Uri.parse(
                                    'https://lobster-app-r8jem.ondigitalocean.app/yolo/'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8'
                                },
                                body: jsonEncode(
                                  <String, String>{'filename': globals.name},
                                ));

                            if (yoloResponse.statusCode == 200) {
                              yoloResultDict =
                                  await jsonDecode(await yoloResponse.body);
                              resultDict['yolo'] = yoloResultDict;
                              for (Map box in yoloResultDict) {
                                ensembleDict['boxes']![2].add(box['box']);
                                ensembleDict['scores']![2].add(box['score']);
                                ensembleDict['classes']![2].add(box['cls']);
                              }
                            }
                            setState(() {
                              end[3] = true;
                            });

                            var ensembleResponse = await http.post(
                                Uri.parse(
                                    'https://lobster-app-r8jem.ondigitalocean.app/ensemble/'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8'
                                },
                                body: jsonEncode(ensembleDict));

                            if (ensembleResponse.statusCode == 200) {
                              ensembleResultDict =
                                  await jsonDecode(await ensembleResponse.body);
                              resultDict['ensemble'] = ensembleResultDict;
                            }

                            setState(() {
                              visible = false;
                              end[0] = false;
                              end[1] = false;
                              end[2] = false;
                              end[3] = false;
                            });

                            print(await yoloResultDict);
                            print(await resultDict);

                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                          apiResult: resultDict,
                                          image: img8List,
                                        )));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: visible,
              child: Container(
                color: Color(0xff000201),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: screenWidth / 4,
                          color: end[0] ? Colors.lightBlue : Colors.transparent,
                        ),
                        Container(
                          height: 20,
                          width: screenWidth / 4,
                          color: end[1] ? Colors.lightBlue : Colors.transparent,
                        ),
                        Container(
                          height: 20,
                          width: screenWidth / 4,
                          color: end[2] ? Colors.lightBlue : Colors.transparent,
                        ),
                        Container(
                          height: 20,
                          width: screenWidth / 4,
                          color: end[3] ? Colors.lightBlue : Colors.transparent,
                        )
                      ],
                    ),
                    Container(
                      // color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Processing in progress... This might take 2 - 3 minutes...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
