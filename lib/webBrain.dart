import 'package:flutter/material.dart';

List modelsName = [
  "v8",
  "v9",
  "yolo",
  "ensemble",
];

List diseasesList = [
  "Caries",
  "Periapical Lesion (PL)",
  "root canal treatment (RCT)",
  "recurrent caries (RC)",
  "remaining root (RR)",
  "URCT",
  "Crown",
  "overhang restoration (OR)",
  "ROOT",
  "CNFT",
  "Perio",
];

List diseasesListColors = [
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.green,
  Colors.red,
  Colors.white24,
  Colors.cyanAccent,
  Colors.purple,
  Colors.pinkAccent,
  Colors.brown,
  Colors.white,
];

List<bool> diseasesMenu = [
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
];

Map<String, List> boxesBuilder(context, dynamic modelsResult) {
  List<List<Widget>> allDiseases = [];
  Map<String, List<List<Widget>>> allModelResult = {};

  Map dimensions = getDimensions(context);
  double imageWidth = dimensions["imageWidth"];
  double imageHeight = dimensions["imageHeight"];
  double widthBias = dimensions["widthBias"];
  double heightBias = dimensions["heightBias"];

  double threshold = 0.10;
  Map cleanApiResult = boxesCleaner(modelsResult, threshold);

  int cls;
  for (var i in modelsName) {
    allDiseases = [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ];

    for (var j = 0; j < cleanApiResult[i].length; j++) {
      double Ymin = cleanApiResult[i][j]["box"][0];
      double Xmin = cleanApiResult[i][j]["box"][1];
      double Ymax = cleanApiResult[i][j]["box"][2];
      double Xmax = cleanApiResult[i][j]["box"][3];

      int score = (cleanApiResult[i][j]["score"] * 100).toInt();
      cls = (cleanApiResult[i][j]["cls"]).toInt();

      allDiseases[cls].add(
        Positioned(
          left: Xmin * imageWidth + widthBias,
          top: Ymin * imageHeight + heightBias - 10,
          child: Column(
            children: [
              Container(
                color: diseasesListColors[cls], //diseasesList[cls]
                child: Text(
                  "${score.toString()}%",
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Container(
                width: (Xmax - Xmin) * imageWidth,
                height: (Ymax - Ymin) * imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 2,
                    color: diseasesListColors[cls],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    allModelResult[i] = allDiseases;
  }

  return allModelResult;
}

Map getDimensions(context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  double imageWidth = screenWidth / 2.5;
  double imageHeight = screenHeight / 1.5;

  double widthBias = (screenWidth - imageWidth) / 2;
  double heightBias = (screenHeight - imageHeight) / 2;
  return {
    "imageWidth": imageWidth,
    "imageHeight": imageHeight,
    "widthBias": widthBias,
    "heightBias": heightBias
  };
}

Map<String, List> boxesCleaner(Map modelsBoxes, double threshold) {
  Map<String, List> cleanBoxes = {};
  for (var model in modelsName) {
    cleanBoxes[model] = thresholdChecker(modelsBoxes[model], threshold);
  }
  return cleanBoxes;
}

List thresholdChecker(List singleModelBoxes, double threshold) {
  List temp = [];
  for (var i = 0; i < singleModelBoxes.length; i++) {
    if (singleModelBoxes[i]['score'] > threshold) temp.add(singleModelBoxes[i]);
  }
  return temp;
}
