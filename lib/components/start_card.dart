import 'package:flutter/material.dart';
import 'dart:ui';

class Start_card extends StatefulWidget{
  int number;
  String image;
  String label;
  dynamic onClick;
  Start_card({this.number = 0, this.image = '', this.label= '', this.onClick });

  @override
  State<Start_card> createState() => _Start_cardState();
}

class _Start_cardState extends State<Start_card> {
  bool animated = false;
  bool left_top = false;
  bool right_top = false;
  bool left_bottom = false;
  bool right_bottom = false;

  play_animation(){
    setState(() {
      if(animated){
        animated = false;
      } else{
        animated = true;
      }
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), play_animation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ widget.onClick(); },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 52,
          width: 310,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                    height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                    begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        0.4,
                        0.6,
                        0.9,
                      ],
                      colors: [
                        Colors.yellow,
                        Colors.red,
                        Colors.purple,
                        Colors.purpleAccent,
                      ],
                    )
                ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    height: 46,
                    width: 306,
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  child: Center(child: Text(widget.label, style: Theme.of(context).textTheme.headline6))
                )
              ),
              Positioned(
                  left: -1,
                  top: -1,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: const Color(0xFF212121),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0),
                      child: Image.asset(widget.image, height: 28, width: 28),
                    ),
                  )),
            ]
          ),
        ),
      ),
    );
  }
}