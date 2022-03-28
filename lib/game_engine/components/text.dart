import 'package:flutter/material.dart';


class Label extends StatefulWidget{
  bool stack;
  double font_size;
  FontWeight weight;
  Color color;
  late String text;
  late String font_familly;
  late var onTap;
  late double opacity;
  late double margin;

  Label({ this.stack = false, this.font_size = 22.0,
          this.font_familly = "", this.text = '',
          this.weight= FontWeight.w500, this.color = Colors.black87,
          this.onTap, this.opacity= 1.0, this.margin = 1.0 });

  @override
  Label_state createState() => Label_state();
}

class Label_state extends State<Label>{
  @override
  Widget build(BuildContext context) {
    if(widget.stack){
      return GestureDetector(
        onTap: widget.onTap,
        child: Opacity(
          opacity: widget.opacity,
          child: Container(
            margin: EdgeInsets.all(widget.margin),
            child: Stack(
              children: [
                Text(widget.text)
              ],
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
          onTap: widget.onTap,
          child: Opacity(
            opacity: widget.opacity,
            child: Padding(
              padding: EdgeInsets.all(widget.margin),
              child: Text(widget.text,
                  style: TextStyle(
                      fontSize: widget.font_size,
                      fontWeight: widget.weight,
                      fontFamily: widget.font_familly,
                      color: widget.color)
              ),
            ),
          )
      );
    }
  }
}