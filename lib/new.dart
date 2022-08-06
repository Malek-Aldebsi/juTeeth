import 'package:flutter/material.dart';

double width = 0;
double height = 0;

class neww extends StatelessWidget {
  final image;
  final boxes;

  neww({required this.image, required this.boxes});

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
        child: DrawBoxes(
          apiResult: boxes,
          image: image,
        ),
      ),
    );
  }
}

class DrawBoxes extends StatefulWidget {
  final apiResult;
  final image;

  DrawBoxes({required this.apiResult, required this.image});

  @override
  State<DrawBoxes> createState() => _DrawBoxesState();
}

class _DrawBoxesState extends State<DrawBoxes> {
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
    return temp;
  }

  List modelsName(Map modelsResult) {
    List temp = [];
    for (var k in modelsResult.keys) {
      if (k != "id" && k != "original" && modelsResult[k] != null) {
        temp.add(k);
      }
    }
    return temp;
  }

  void getDimensions(dynamic image) async {
    var decodedImage = await decodeImageFromList(widget.image!);
    setState(() {
      width = decodedImage.width * 65 / 100 as double;
      height = decodedImage.height * 65 / 100 as double;
    });
  }

  List<Widget> singleImageBoxes(dynamic modelsResult) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double widthBias = (screenWidth - width) / 2;
    double heightBias = (screenHeight - height) / 2;

    List<Widget> singleImage = [];
    List<Widget> allImages = [];

    for (var i = 0; i < positiveApiResult.length; i++) {
      singleImage = [
        Positioned(
            child: Container(
          width: double.infinity,
          height: height,
        )),
        Positioned(
          left: widthBias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.memory(
              widget.image,
              width: width,
              height: height,
              // alignment: Alignment.topCenter,
            ),
          ),
        )
      ];

      for (var j = 0; j < positiveApiResult[i].length; j++) {
        double ymin = positiveApiResult[i][j]["box"][0];
        double xmin = positiveApiResult[i][j]["box"][1];
        double ymax = positiveApiResult[i][j]["box"][2];
        double xmax = positiveApiResult[i][j]["box"][3];

        int score = (positiveApiResult[i][j]["score"] * 100).toInt();

        Map<String, double> _position = {
          'x': xmin * width + widthBias,
          'y': ymin * height,
          'w': (xmax - xmin) * width,
          'h': (ymax - ymin) * height,
        };

        singleImage.add(Positioned(
          left: _position['x'],
          top: _position['y'],
          child: Container(
            width: _position['w'],
            height: _position['h'],
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: Colors.blue,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.blue,
                child: Text(
                  modelName[i] + " " + score.toString() + "%",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
        ));
      }
      allImages.add(Center(
        child: SizedBox(
          height: 100,
          child: Center(
            child: Text(
              modelName[i],
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
      ));
      allImages.add(Stack(children: singleImage));
    }

    return allImages;
  }

  List positiveApiResult = [];
  List modelName = [];

  @override
  initState() {
    positiveApiResult = toModelList(widget.apiResult);
    modelName = modelsName(widget.apiResult);
    getDimensions(widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: singleImageBoxes(positiveApiResult));
  }
}
