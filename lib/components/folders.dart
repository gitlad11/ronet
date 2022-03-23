import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:ronet_engine/components/folder.dart";
import 'package:provider/provider.dart';
import 'package:ronet_engine/providers/path_providers.dart';
import 'package:ronet_engine/handlers/get_directories.dart';

class Folders extends StatefulWidget{
  List items = [{"type" : "file", "name" : 'file.txt'}];
  int chosenItem = 999;
  late String path = '';

  @override
  Folders_state createState() => Folders_state();
}

class Folders_state extends State<Folders> {
  bool drag = false;
  double resized = 230.0;

  on_drag(size){
    if(size > 100.0){
        setState(() {
          resized = size;
        });
  } else {
      setState(() {
        resized = 101.0;
      });
    }
  }

  @override
  void initState() {
    init_items();
    super.initState();
  }

  void reassemble() {
    init_items();
    super.reassemble();
  }


  init_items() async {
    var path = Provider.of<Path_provider>(context, listen: false).path;
    List items = await get_directories(path);
    setState(() {
      widget.path = path;
      widget.items = items;
    });
  }
  setIndex(index) async {
    setState(() {
      if(index != widget.chosenItem){
        widget.chosenItem = index;
      } else {
        widget.chosenItem = 999;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height - 45,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF313131),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 45,
              width: resized,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)

                      ),
                      child: Text(widget.path, style: Theme.of(context).textTheme.labelLarge)
                  ),
                  const SizedBox( height: 20 ),
                  Container(
                    height: MediaQuery.of(context).size.height - 120,
                    width: resized,
                    child: widget.items.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Folder( resized: resized, setChosen: setIndex, index: index, chosenItem: widget.chosenItem, type: widget.items[index]['type'], name: widget.items[index]['name'], path: widget.items[index]['path'], empty: widget.items[index]['empty'] );
                      },

                    ) : const SizedBox(),
                  )

                ],
              ),
            ),
            GestureDetector(
              onLongPressCancel: (){
                setState(() {
                  drag = false;
                });
              },
              onLongPressUp: (){
                setState(() {
                  drag = false;
                });
              },
              onLongPressMoveUpdate: (event){
                if(drag){
                  on_drag(event.globalPosition.dx);
                } else {
                  setState(() {
                    drag = true;
                  });
                }
              },
              onTapDown: (_){
                setState(() {
                  drag = true;
                });
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: Container(
                  width: 6,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                  decoration: BoxDecoration(
                    color: drag ? Colors.redAccent : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}