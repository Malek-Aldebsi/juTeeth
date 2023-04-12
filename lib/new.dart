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
  dynamic resultDict;
  dynamic img8List;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff010A19),
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
                child: Text("Denta Vision"),
              )
            ],
          ),
        ),
      ),
      body: Stack(
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
            child: Container(
              height: 400,
              width: 700,
              child: DropZoneWidget(
                onDroppedFile: (file) async {
                  setState(() => this.file = file);

                  http.Response img = await http.get(
                    Uri.parse(file.url),
                  );

                  img8List = await img.bodyBytes;

                  var request = http.MultipartRequest(
                      'POST',
                      Uri.parse(
                          'https://ju-teeth-5qt4f.ondigitalocean.app/upload/'));
                  request.files.add(http.MultipartFile.fromBytes(
                      'image', img8List,
                      filename: globals.name,
                      contentType: new MediaType('image', 'png')));
                  request.fields['v8'] = "True";
                  request.fields['v9'] = "False";
                  request.fields['ensemble'] = "False";
                  request.headers['Content-Type'] =
                      'application/json; charset=UTF-8';
                  var response = await request.send();

                  if (response.statusCode == 200) {
                    resultDict =
                        await jsonDecode(await response.stream.bytesToString());
                    print(resultDict);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultPage(
                                  apiResult: resultDict,
                                  image: img8List,
                                )));
                  } else {
                    print(await response.stream.bytesToString());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
