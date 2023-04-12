import 'dart:math';

import 'uploadImage/file_DataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';
import 'globals.dart' as globals;

class DropZoneWidget extends StatefulWidget {
  final ValueChanged<File_Data_Model> onDroppedFile;

  const DropZoneWidget({Key? key, required this.onDroppedFile})
      : super(key: key);
  @override
  _DropZoneWidgetState createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  late DropzoneViewController controller;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return buildDecoration(
        child: Container(
      decoration: BoxDecoration(
        color: highlight ? Color(0xffDCE2F0) : Color(0xffF0F3FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          DropzoneView(
            onCreated: (controller) => this.controller = controller,
            onDrop: UploadedFile,
            onHover: () => setState(() => highlight = true),
            onLeave: () => setState(() => highlight = false),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: screenHeight / 10,
                  color: Color(0xff989FAE),
                ),
                RichText(
                  text: new TextSpan(
                    style:
                        new TextStyle(color: Color(0xff989FAE), fontSize: 14),
                    children: [
                      new TextSpan(text: 'Drag and drop or '),
                      new TextSpan(
                          text: 'browse to choose image',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future UploadedFile(dynamic event) async {
    var rng = Random();
    for (var i = 0; i < 10; i++) {
      globals.name =
          '${rng.nextInt(100)}${rng.nextInt(100)}${rng.nextInt(100)}${rng.nextInt(100)}.png';
    }

    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    print('Name : ${globals.name}');
    print('Mime: $mime');

    print('Size : ${byte / (1024 * 1024)}');
    print('URL: $url');

    final droppedFile =
        File_Data_Model(name: globals.name, mime: mime, bytes: byte, url: url);

    widget.onDroppedFile(droppedFile);
    setState(() {
      highlight = false;
    });
  }

  // height
  Widget buildDecoration({required Widget child}) {
    final colorBackground = Color(0xffB0B5CB);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 30),
        color: Color(0xffDCE2F0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Upload your image",
                  style: TextStyle(
                      color: Color(0xff1D1E23),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9.0, bottom: 20),
                  child: Text("PNG, JPG, GIF... files are allowed"),
                ),
              ],
            ),
            Container(
              height: 150,
              child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: colorBackground,
                  strokeWidth: 1,
                  dashPattern: [8, 4],
                  radius: Radius.circular(10),
                  padding: EdgeInsets.all(1.5),
                  child: InkWell(
                      onTap: () async {
                        final events = await controller.pickFiles();
                        if (events.isEmpty) return;
                        UploadedFile(events.first);
                      },
                      child: child)),
            ),
          ],
        ),
      ),
    );
  }
}
