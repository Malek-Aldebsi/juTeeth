// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

void main() async {
  var request =
      http.MultipartRequest('POST', Uri.parse('http://localhost:8000/v9/'));
  request.files.add(http.MultipartFile.fromBytes(
      'image', File('images/osama.jpg').readAsBytesSync(),
      filename: 'img.png', contentType: new MediaType('image', 'png')));
  request.fields['filename'] = 'test.png';

  request.headers['Content-Type'] = 'application/json; charset=UTF-8';
  // request.headers["Access-Control-Allow-Origin"] = "*";

  var response = await request.send();

  dynamic resultDict = jsonDecode(await response.stream.bytesToString());

  print(resultDict.toString());
}
