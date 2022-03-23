import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Component_item extends StatefulWidget{
  String label;
  String value;

  Component_item({this.label = '', this.value = '1.0' });

  @override
  Component_item_state createState() => Component_item_state();
}

class Component_item_state extends State<Component_item>{
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.value.toString();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      height: 22,
      width: 320,
      child: Row(
        children: [
          Text(widget.label + ": ", style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(width: 3),
          Expanded(
            child: TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(2),
              border: OutlineInputBorder(),
            ),
            ),
          )
        ],
      ),
    );
  }
}