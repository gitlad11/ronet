import 'package:flutter/material.dart';

class Interface_column extends StatefulWidget{
  late List items;
  late double padding_all;
  late double margin_all;
  late double padding_left;
  late double padding_right;
  late double padding_top;
  late double padding_bottom;
  late double margin_left;
  late double margin_right;
  late double margin_top;
  late double margin_bottom;
  late double opacity;
  late double background_opacity;
  late Color color;
  double height;
  double width;

  Interface_column({
    this.items = const [],
    this.padding_all = 5.0,
    this.margin_all = 0.0,
    this.opacity = 1,
    this.color = Colors.white,
    this.background_opacity = 1.0,
    this.height = 0.0,
    this.width = 0.0,
    this.padding_left = 0.0,
    this.padding_right = 0.0,
    this.padding_top = 0.0,
    this.padding_bottom = 0.0,
    this.margin_left = 0.0,
    this.margin_right = 0.0,
    this.margin_top = 0.0,
    this.margin_bottom = 0.0,
  });

  @override
  Interface_column_state createState() => Interface_column_state();
}

class Interface_column_state extends State<Interface_column>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.width > 0.0 ? MediaQuery.of(context).size.height : widget.height,
      width: widget.width > 0.0 ? MediaQuery.of(context).size.width : widget.width,
      padding: widget.padding_all > 0.0 ? EdgeInsets.all(widget.padding_all) :
        EdgeInsets.only(
            left: widget.padding_left,
            right: widget.padding_right,
            top: widget.padding_top,
            bottom: widget.padding_bottom),
      margin: widget.margin_all > 0.0 ? EdgeInsets.all(widget.margin_all) :
      EdgeInsets.only(
          left: widget.margin_left,
          right: widget.margin_right,
          top: widget.margin_top,
          bottom: widget.margin_bottom),
      decoration: BoxDecoration(
        color: widget.color.withOpacity(widget.background_opacity),
      ),
      child: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return widget.items[index];
        },
      ),
    );
  }
}