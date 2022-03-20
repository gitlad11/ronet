import 'package:flutter/material.dart';
import 'package:ronet_engine/start.dart';

class Navbar_item extends StatefulWidget{
  String title;

  Navbar_item({ this.title = '' });

  @override
  Navbar_item_state createState() => Navbar_item_state();
}

class Navbar_item_state extends State<Navbar_item>{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start()));
        }, child: Text(widget.title, style: Theme.of(context).textTheme.button)),
        const SizedBox(width: 8),
      ],
    );
  }
}