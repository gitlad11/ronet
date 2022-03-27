import 'package:flutter/material.dart';

class Component_dropdown extends StatefulWidget{
  List items;
  List icons = [Icons.question_mark, Icons.square_sharp, Icons.videocam_rounded, Icons.animation, Icons.surround_sound, Icons.gif, Icons.gif];
  List methods = [];

  Component_dropdown({ this.icons = const [],  this.items = const [], this.methods = const [] });

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

        return TextButton(onPressed: (){}, child: Padding(
          padding: const EdgeInsets.all(8.0),
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