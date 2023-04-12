// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:jute/sliderButton.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:jute/teeeeeest.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FstPage(),
//     );
//   }
// }
//
// class FstPage extends StatefulWidget {
//   const FstPage({Key? key}) : super(key: key);
//
//   @override
//   State<FstPage> createState() => _FstPageState();
// }
//
// class _FstPageState extends State<FstPage> {
//   bool imageAvailable = false;
//
//   dynamic imageFile;
//   String imageName = "No file chosen";
//   String submit = "Submit";
//
//   String isCaries = "True";
//   String isPL = "True";
//   String isRCT = "True";
//   String isFRCNN = "True";
//   String isAtrous = "True";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff010A19),
//         title: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(25.0),
//                 child: const Image(
//                   height: 40,
//                   width: 40,
//                   image: AssetImage("images/logo.png"),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15.0),
//                 child: Text("Denta Vision"),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("images/img1.jpeg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 50.0),
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 50),
//                   constraints: const BoxConstraints(
//                     maxWidth: 800.0,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // const Padding(
//                         //   padding: EdgeInsets.only(bottom: 5.0),
//                         //   child: Text(
//                         //     "Upload Photo",
//                         //     style: TextStyle(
//                         //         fontSize: 30, fontWeight: FontWeight.bold),
//                         //   ),
//                         // ),
//                         // const Padding(
//                         //   padding: EdgeInsets.symmetric(vertical: 5.0),
//                         //   child: Text("Photo",
//                         //       style: TextStyle(
//                         //         fontSize: 16,
//                         //       )),
//                         // ),
//                         Row(
//                           children: [
//                             Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   constraints: const BoxConstraints(
//                                     minHeight: 38.0,
//                                     maxHeight: 38.0,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: const Color(0xffDDE0E3)),
//                                     color: const Color(0xffDDE0E3),
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(8.0),
//                                       bottomLeft: Radius.circular(8.0),
//                                     ),
//                                   ),
//                                   child: MaterialButton(
//                                     focusColor: const Color(0xffC9CCCF),
//                                     onPressed: () async {
//                                       final image = await ImagePickerWeb
//                                           .getImageAsBytes();
//
//                                       setState(() {
//                                         imageFile = image!;
//                                         imageName = "image.png";
//                                       });
//                                     },
//                                     child: const Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         child: Text(
//                                           "Choose File",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                             // Expanded(
//                             //   flex: 3,
//                             //   child: Container(
//                             //     constraints: const BoxConstraints(
//                             //       minHeight: 38.0,
//                             //       maxHeight: 38.0,
//                             //     ),
//                             //     decoration: BoxDecoration(
//                             //       borderRadius: const BorderRadius.only(
//                             //         topRight: Radius.circular(3.0),
//                             //         bottomRight: Radius.circular(3.0),
//                             //       ),
//                             //       border: Border.all(
//                             //         color: const Color(0xffDDE0E3),
//                             //       ),
//                             //     ),
//                             //     child: Padding(
//                             //       padding: const EdgeInsets.symmetric(
//                             //           vertical: 8.0, horizontal: 15),
//                             //       child: FittedBox(
//                             //         fit: BoxFit.scaleDown,
//                             //         alignment: Alignment.centerLeft,
//                             //         child: Text(
//                             //           imageName,
//                             //           style: const TextStyle(fontSize: 16),
//                             //         ),
//                             //       ),
//                             //     ),
//                             //   ),
//                             // )
//                           ],
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.only(top: 10.0),
//                         //   child: TextButton(
//                         //       style: ButtonStyle(
//                         //           backgroundColor:
//                         //               MaterialStateProperty.all(Colors.blue)),
//                         //       onPressed: () async {
//                         //         setState(() {
//                         //           submit = "loading";
//                         //         });
//                         //         var request = http.MultipartRequest(
//                         //             'POST',
//                         //             Uri.parse(
//                         //                 'http://juteeth.pythonanywhere.com/api/upload'));
//                         //         request.files.add(http.MultipartFile.fromBytes(
//                         //             'image', imageFile,
//                         //             filename: 'img1.png',
//                         //             contentType:
//                         //                 new MediaType('image', 'png')));
//                         //         request.fields['caries'] = isCaries;
//                         //         request.fields['pl'] = isPL;
//                         //         request.fields['rct'] = isRCT;
//                         //         request.fields['frcnn'] = isFRCNN;
//                         //         request.fields['atrous'] = isAtrous;
//                         //         // request.headers['Content-Type'] =
//                         //         //     'application/json; charset=UTF-8';
//                         //         request.headers["Access-Control-Allow-Origin"] =
//                         //             "*";
//                         //         var response = await request.send();
//                         //
//                         //         dynamic resultDict;
//                         //
//                         //         if (response.statusCode == 200) {
//                         //           resultDict = jsonDecode(
//                         //               await response.stream.bytesToString());
//                         //         }
//                         //         print(resultDict);
//                         //         Navigator.push(
//                         //             context,
//                         //             MaterialPageRoute(
//                         //                 builder: (context) => ResultPage(
//                         //                       apiResult: resultDict,
//                         //                       image: imageFile,
//                         //                     )));
//                         //       },
//                         //       child: Text(
//                         //         submit,
//                         //         style: const TextStyle(
//                         //             color: Colors.white, fontSize: 15),
//                         //       )),
//                         // )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: App(),
    ),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(
          3.1415926535897932 / 4,
        ),
        child: Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    width: 200, // the size you prefer
                    height: 200,
                    transformAlignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      -3.1415926535897932 / 4, // here
                    ),
                    child: Image.asset('images/logo.png')))));
  }
}
