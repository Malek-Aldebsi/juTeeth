// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://juteeth.pythonanywhere.com/api/upload'));
  request.files.add(http.MultipartFile.fromBytes(
      'image', File('images/test.jpg').readAsBytesSync(),
      filename: 'img1.png', contentType: new MediaType('image', 'png')));
  request.fields['caries'] = "True";
  request.fields['pl'] = "True";
  request.fields['rct'] = "True";
  request.fields['frcnn'] = "True";
  request.fields['atrous'] = "False";
  var response = await request.send();

  dynamic resultDict = jsonDecode(await response.stream.bytesToString());

  List thresholdChecker(List result) {
    List temp = [];
    for (var i = 0; i < result.length; i++) {
      if (result[i]['score'] > 0.1000) temp.add(result[i]);
    }
    return temp;
  }

  List toModelList(Map modelsResult) {
    List temp = [];
    for (var k in modelsResult.keys) {
      if (k != "id" && k != "original" && modelsResult[k] != null) {
        temp.add(thresholdChecker(modelsResult[k]));
      }
    }
    print("\n\n******************");
    print(temp.toString());
    print("\n\n******************");
    return temp;
  }

  toModelList(resultDict);
  print(resultDict.toString());
}

//   if (response.statusCode == 200) {
//     print(response.body);
//     dynamic resultDict = jsonDecode(response.body);
//     dynamic result = resultDict["result"];
//     print(result);
//   } else
//     print(response.body + "********");
