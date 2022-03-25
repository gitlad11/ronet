import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:ronet_engine/components/folder.dart";
import 'package:provider/provider.dart';
import 'package:ronet_engine/providers/folders_provider.dart';
import 'package:ronet_engine/providers/path_providers.dart';
import 'package:ronet_engine/handlers/get_directories.dart';
import 'package:ronet_engine/providers/size_provider.dart';

class Folders extends StatefulWidget{
  List items = [{"type" : "file", "name" : 'file.txt'}];


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
    Provider.of<Size_provider>(context, listen: false).setSideWidth(size);
  }

  @override
  void initState() {
    super.initState();
    init_items();
    Future.delayed( const Duration(milliseconds: 500), init_items);
  }

  void reassemble() {
    super.reassemble();
    Future.delayed( const Duration(milliseconds: 300), init_items);
  }


  init_items() async {
    var path = Provider.of<Path_provider>(context, listen: false).path;
    print(path);
    List items = await get_directories(path);
    Provider.of<Folders_provider>(context, listen: false).setFolders(items);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Folders_provider, Path_provider>(
      builder: (context, folders_provider, path_provider, snapshot) {
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
                          child: Text(path_provider.path, style: Theme.of(context).textTheme.labelLarge)
                      ),
                      const SizedBox( height: 20 ),
                      Container(
                        height: MediaQuery.of(context).size.height - 120,
                        width: resized,
                        child: folders_provider.folders.isNotEmpty ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: folders_provider.folders.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Folder(resized: resized,
                                index: index,
                                type: folders_provider.folders[index]['type'],
                                name: folders_provider.folders[index]['name'],
                                path: folders_provider.folders[index]['path'],
                                empty: folders_provider.folders[index]['empty']);
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
    );
  }

}