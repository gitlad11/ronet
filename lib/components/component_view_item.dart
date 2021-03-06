import 'package:flutter/material.dart';

class Component_view_item extends StatefulWidget{
  String label;

  Component_view_item({ this.label = '' });

  @override
  Component_view_item_state createState() => Component_view_item_state();
}

class Component_view_item_state extends State<Component_view_item>{
  @override

  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.topCenter,
            height: 20,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 2),
                Icon(Icons.crop_square, size: 22, color: Colors.white),
                const SizedBox(width: 5),
                Text(widget.label, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}