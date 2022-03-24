import 'package:flutter/material.dart';

class Directory_item extends StatefulWidget {
  String name;
  String path;
  String type;
  bool empty;
  
  var onClick;

  Directory_item({this.name = "", this.path = '', this.type = "directory", this.empty = false, required this.onClick });

  @override
  Directory_item_state createState() => Directory_item_state();
}

class Directory_item_state extends State<Directory_item>{
  bool hover = false;

  handleHover() async {
    setState(() {
      hover = true;
    });
  }

  handleUnHover() async {
    setState(() {
      hover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_){
        setState(() {
          hover = true;
        });
      },
      onExit: (_){
        setState(() {
          hover = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if(widget.type == 'directory'){
            widget.onClick(widget.path);
            }
          },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: hover ? Colors.white10 : Colors.black12,
          height: 30,
          width: 200,
          padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.type == "directory" && widget.empty ? Image.asset("assets/empty_follder.png", width: 22, height: 22) :
              widget.type == "directory" && !widget.empty ? Image.asset("assets/full_folder.png", width: 22, height: 22) :
              widget.type == "image" ? Image.asset("assets/image_full.png", width: 22, height: 22) :
              widget.type == "file" ? Image.asset("assets/document.png", width: 22, height: 22) :
              const SizedBox(),
              const SizedBox(width: 5),
              Expanded(child: Text(widget.name, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        ),
      ),
    );
  }
}