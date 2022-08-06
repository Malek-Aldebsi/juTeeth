import 'package:flutter/material.dart';

class SliderButton extends StatefulWidget {
  final onPress;
  SliderButton({this.onPress});

  @override
  State<SliderButton> createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  bool pressed = false;
  var alignment = MainAxisAlignment.start;
  Color backGroundColor = Colors.white;
  Color buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDDE0E3)),
        borderRadius: BorderRadius.circular(20),
        color: backGroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: alignment,
        children: [
          GestureDetector(
            onTap: () {
              widget.onPress();
              setState(() {
                if (pressed) {
                  alignment = MainAxisAlignment.start;
                  backGroundColor = Colors.white;
                  buttonColor = Colors.blue;
                  pressed = false;
                } else {
                  alignment = MainAxisAlignment.end;
                  backGroundColor = Colors.blue;
                  buttonColor = Colors.white;
                  pressed = true;
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: 23,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: buttonColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
