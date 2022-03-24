import 'package:flutter/material.dart';
import 'package:ronet_engine/start.dart';

class Navbar_item extends StatefulWidget{
  String title;
  var icon;
  var setDropDown;
  var leaveDropDown;
  int index;

  Navbar_item({ this.title = '', this.icon, this.setDropDown, this.leaveDropDown, this.index = 0 });

  @override
  Navbar_item_state createState() => Navbar_item_state();
}

class Navbar_item_state extends State<Navbar_item>{
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_){
        widget.setDropDown(widget.index);
      },
      child: SizedBox(
        child: Row(
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
        ),
      ),
    );
  }
}