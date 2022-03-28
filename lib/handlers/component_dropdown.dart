import 'dart:io';

import 'package:flutter/material.dart';

class Component_dropdown extends StatefulWidget{
  List items;
  List icons;
  var method;
  Component_dropdown({ this.icons = const [],  this.items = const [], this.method });

  @override
  Component_dropdown_state createState() => Component_dropdown_state();
}

class Component_dropdown_state extends State<Component_dropdown>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ListView.builder(
          itemCount: widget.items.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {

        return TextButton(onPressed: (){
           widget.method(index);
        }, child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.icons.isNotEmpty ? Icon(widget.icons[index], size: 20, color: Colors.white) : SizedBox(),
              const SizedBox(width: 4),
              Text(widget.items[index], style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ));
      })
    );
  }
}