import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/providers/scenes_provider.dart';

class Tab_item extends StatefulWidget{
  String name;
  String path;
  String current;
  int index;
  Tab_item({this.name = '', this.path = '', this.current = '', this.index = 0});

  @override
  Tab_state createState() => Tab_state();
}

class Tab_state extends State<Tab_item>{


  on_close(){
    Provider.of<Scenes_provider>(context, listen: false).close_scene(widget.index);
  }
  on_click(){
    Provider.of<Scenes_provider>(context, listen: false).set_current_scene({ "name" : widget.name, "path" : widget.path });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        on_click();
      },
      child: Container(
        height: 30,
        width: 200,
        margin: const EdgeInsets.only(left: 5),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.current == widget.name ? Colors.blue.shade400 : Colors.blueAccent.shade400,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6),),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(widget.name, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelMedium)),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: (){
                on_close();
              },
              child: const Icon(Icons.close, size: 18, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}