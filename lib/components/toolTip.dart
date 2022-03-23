import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToolTip extends StatefulWidget{
  String label;

  ToolTip({this.label = ''});

  @override
  ToolTip_state createState() => ToolTip_state();
}

class ToolTip_state extends State<ToolTip>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left : 3.0, top: 2),
        child: Text(widget.label, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}