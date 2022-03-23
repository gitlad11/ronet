import 'package:flutter/material.dart';
import 'package:ronet_engine/components/folder.dart';
import 'package:ronet_engine/handlers/get_directories.dart';
import 'package:ronet_engine/components/folder_item.dart';

class Folder_item extends StatefulWidget {
  String type;
  String name;
  String path;
  bool empty;
  double resized;
  List items = [];
  Folder_item({this.resized = 220, this.type='', this.name = '', this.path = '', this.empty = false });

  @override
  Folder_item_state createState() => Folder_item_state();
}

class Folder_item_state extends State<Folder_item> {
  bool opened = false;
  bool hover = false;

  @override
  void initState() {
    super.initState();
  }

  init_items() async {
    List items = await get_directories(widget.path);
    print(items);
    setState(() {
      widget.items = items;
    });
  }

  handle_open(){
    setState(() {
      if(opened){
        opened = false;
      } else {
        opened = true;
      }
    });
    init_items();
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
        onTap: (){
          handle_open();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 30,
                width: 220,
                decoration: BoxDecoration(
                    color: hover ? Colors.black26 : Colors.black.withOpacity(0)
                ),
                child: widget.type == 'directory' ? Row(
                  children: [
                    opened ? const Icon(Icons.keyboard_arrow_down, size: 20,) : const Icon(Icons.keyboard_arrow_left, size: 20),
                    const SizedBox(width: 6),
                    Image.asset("assets/full_folder.png", width: 18, height: 18),
                    const SizedBox(width: 6),
                    Text(widget.name, style: Theme.of(context).textTheme.labelMedium)
                  ],
                ) : Row(
                  children: [
                    const SizedBox(width: 6),
                    widget.type == 'image' ? Image.asset("assets/image_full.png", width: 18, height: 18) :
                    Image.asset("assets/document.png", width: 18, height: 18),
                    const SizedBox(width: 6),
                    Text(widget.name, style: Theme.of(context).textTheme.labelMedium)
                  ],
                )
            ),
            opened ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 300,
                  alignment: Alignment.centerLeft,
                  child: widget.items.length > 0 ? ListView.builder(
                    itemCount: widget.items.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Folder( resized: widget.resized, type: widget.items[index]['type'], name: widget.items[index]['name'], path: widget.items[index]['path'], empty: widget.items[index]['empty'] );
                    },
                  ) : const SizedBox(),
                ),
              ],
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }

}