import 'package:flutter/material.dart';
import 'package:ronet_engine/components/button.dart';
import 'package:ronet_engine/components/create_card.dart';
import 'package:ronet_engine/components/directories.dart';
import 'package:ronet_engine/components/input.dart';
import 'package:ronet_engine/components/search_modal.dart';
import 'package:ronet_engine/handlers/get_directories.dart';
import 'package:ronet_engine/handlers/get_disks.dart';
import 'package:ronet_engine/handlers/search_directory.dart';
import 'package:ronet_engine/folder_view.dart';
import 'package:ronet_engine/start.dart';

class Create_project extends StatefulWidget{
  List disk_list = [];
  List items = [];
  List search_items = [];
  List history = [];

  @override
  Create_project_state createState() => Create_project_state();
}

class Create_project_state extends State<Create_project>{
  int chosenItem = 0;
  bool show_search = false;
  bool searching = false;
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();

  setItem(index){
    setState(() {
      chosenItem = index;
    });
  }

  @override
  void initState() {
    init_items();
    super.initState();
    controller.addListener(_focus_controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_focus_controller);
    controller.dispose();
    focus.dispose();
  }


  void _focus_controller() {
    if(!searching){
      if(focus.hasFocus){
        setState(() {
          searching = true;
        });
        Future.delayed( const Duration(milliseconds: 1000),on_search);
      }
    }
  }

  on_search() async {
    setState(() {
      searching = false;
    });
    List query = controller.text.split(r'\');
    String reqExp = query.last;
    query.removeLast();
    String path = query.join();
    List items = await search_directory(path, reqExp);
    setState(() {
      widget.search_items = items;
      show_search = true;
    });
  }


  init_items () async {
    List disk = await get_disks();
    List directories = await get_directories(disk[0]);
    setState(() {
      widget.disk_list = disk;
      widget.items = directories;
      widget.history.add(disk[0]);
      controller.text = disk[0];
    });
  }


  go_to_directory(directory) async {
    List directories = await get_directories(directory);
    setState(() {
      widget.items = directories;
      widget.history.add(directory);
      controller.text = directory;
      show_search = false;
    });
  }

  change_disk(disk) async {
    List directories = await get_directories(disk);
    setState(() {
      widget.history = [];
      widget.items = directories;
      widget.history.add(disk);
      controller.text = disk;
    });
  }

  return_to() async {
    var back_directory;
    if(widget.history.length > 1){
      widget.history.removeLast();
      back_directory = widget.history.last;
    } else {
      back_directory = widget.history[1];
    }
    List directories = await get_directories(back_directory);
    setState(() {
      widget.items = directories;
      controller.text = back_directory;
    });
  }

  hide_search(){
    setState(() {
      show_search = false;
    });
  }
  go_back () async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start() ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            )),
        leading: GestureDetector(
          onTap: (){
            go_back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left : 8.0),
            child: Icon(Icons.arrow_back, size: 26),
          ),
        ),
        title: const Text("?????????????? ????????????", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: 1000,
            height: 910,
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: 900,
                  height: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Create_card(image: "assets/dart.png", name: "2d ???????????? ???? ?????????? dart", index: 0, chosenItem: chosenItem, choseItem: setItem),
                      const SizedBox(width: 30),
                      Create_card(image: "assets/2d.png", name: "2d ????????????", index: 1, chosenItem: chosenItem, choseItem: setItem),
                      const SizedBox(width: 30),
                      Create_card(image: "assets/3d.png", name: "3d ????????????", index: 2, chosenItem: chosenItem, choseItem: setItem),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 600,
                      height: 600,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Input("email",
                                  const Icon(
                                    Icons.folder,
                                    color: Color(0xFFE5E3E8),
                                    size: 22,
                                  ),
                                  controller,
                                  focus,
                                  return_to
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 160,
                                  width: 100,
                                  padding: const EdgeInsets.only(left: 30),
                                  child: widget.disk_list.isNotEmpty ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("????????:", style: Theme.of(context).textTheme.bodyLarge),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: widget.disk_list.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                      onTap: (){ change_disk(widget.disk_list[index]); },
                                                      child: Text(widget.disk_list[index], style: const TextStyle(color: Colors.blueAccent, fontSize: 17, fontWeight: FontWeight.w500))
                                                  )
                                              ),
                                            );
                                          }
                                      )
                                    ],
                                  ) : const SizedBox(),
                                ),
                                Directories(items: widget.items, go_to_directory : go_to_directory )
                              ]
                          ),
                          const SizedBox(height: 10),
                          RoundedButton(text: "??????????????", color: Colors.blueAccent, press: (){})
                        ],
                      ),
                    ),
                    show_search ? Positioned(
                        top: 103,
                        child: GestureDetector(
                          onTap: (){ hide_search(); },
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black.withOpacity(0),
                          ),
                        )) : const SizedBox(),
                    show_search ? Positioned(
                        top: 102,
                        left: 80,
                        child: Search_modal( items : widget.search_items, go_to_directory : go_to_directory )
                    ) : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}