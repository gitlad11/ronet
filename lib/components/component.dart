import 'package:flutter/material.dart';
import 'package:ronet_engine/components/component_item.dart';

class Component extends StatefulWidget{
  String label;
  List items;

  Component({this.label = '', this.items = const []});

  @override
  Component_state createState() => Component_state();
}

class Component_state extends State<Component>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.label, style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 320,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Component_item(label: widget.items[index]['name'], value: widget.items[index]['value'],);
              },
            ),
          )
        ],
      )
    );
  }
}