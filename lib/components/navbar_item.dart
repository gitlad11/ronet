import 'package:flutter/material.dart';
import 'package:ronet_engine/start.dart';

class Navbar_item extends StatefulWidget{
  String title;
  var icon;
  Navbar_item({ this.title = '', this.icon });

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
        }, child: Row(
          children: [
            widget.icon != null ?
            Icon(widget.icon, size: 22, color: Colors.white) :
            const SizedBox()
            ,
            const SizedBox(width: 2),
            Text(widget.title, style: Theme.of(context).textTheme.button),
          ],
        )),
        const SizedBox(width: 8),
      ],
    );
  }
}