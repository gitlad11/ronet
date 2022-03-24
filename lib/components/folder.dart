import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ronet_engine/handlers/get_directories.dart';
import 'package:ronet_engine/components/folder_item.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/providers/folders_provider.dart';


class Folder extends StatefulWidget {
   String type;
   String name;
   String path;
   bool empty;
   double resized;
   int index;

   List items = [];
   Folder({this.type='', this.name = '', this.path = '', this.empty = false, this.index = 999, this.resized = 220 });

  @override
  Folder_state createState() => Folder_state();
}

class Folder_state extends State<Folder> {
  bool hover = false;


  init_items() async {
    List items = await get_directories(widget.path);
    Provider.of<Folders_provider>(context, listen: false).setNestedFolders(items, widget.index);
  }

  handle_open() async {
    init_items();
    Provider.of<Folders_provider>(context, listen: false).setFoldersIndex(widget.index);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<Folders_provider>(
      builder: (context, folders_provider, snapshot) {
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
                  width: widget.resized,
                  decoration: BoxDecoration(
                    color: hover ? Colors.black26 : Colors.black.withOpacity(0)
                  ),
                  child: widget.type == 'directory' ? Row(
                    children: [
                      folders_provider.opened_folders.contains(widget.index) ? const Icon(Icons.keyboard_arrow_down, size: 20,) : const Icon(Icons.keyboard_arrow_left, size: 20),
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
                folders_provider.opened_folders.contains(widget.index) ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    folders_provider.nested_folders[widget.index] != null && folders_provider.nested_folders[widget.index].isNotEmpty ? Container(
                      width: widget.resized - 20,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        itemCount: folders_provider.nested_folders[widget.index].length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Folder_item(resized: widget.resized,
                              type: folders_provider.nested_folders[widget.index][index]['type'],
                              name: folders_provider.nested_folders[widget.index][index]['name'],
                              path: folders_provider.nested_folders[widget.index][index]['path'],
                              empty: folders_provider.nested_folders[widget.index][index]['empty'] );
                        },
                      ) ,
                    ) : SizedBox(),
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