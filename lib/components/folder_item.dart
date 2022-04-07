import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/folder.dart';
import 'package:ronet_engine/handlers/get_directories.dart';
import 'package:ronet_engine/components/folder_item.dart';
import 'package:ronet_engine/providers/folders_items_provider.dart';

class Folder_item extends StatefulWidget {
  String type;
  String name;
  String path;
  bool empty;
  int index;
  double resized;
  List items = [];

  Folder_item({this.resized = 220, this.type='', this.name = '', this.path = '', this.empty = false, this.index = 0});

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
    return items;
  }

  handle_open() async {
    List i = await init_items();
    setState(() {
      opened = !opened;
      widget.items = i;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<Folders_items_provider>(
      builder: (context, folders, snapshot) {
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
                    clipBehavior: Clip.hardEdge,
                    duration: const Duration(milliseconds: 300),
                    height: 30,
                    width: widget.resized - 20,
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
                      child: ListView.builder(
                        itemCount: widget.items.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Folder_item(resized: widget.resized,
                              type: widget.items[index]['type'],
                              name: widget.items[index]['name'],
                              index: index + widget.index,
                              path: widget.items[index]['path'],
                              empty: widget.items[index]['empty'] );
                        },
                      ),
                    ),
                  ],
                ) : const SizedBox()
              ],
            ),
          ),
        );
      }
    );
  }

}