import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ronet_engine/components/start_card.dart';
import 'package:ronet_engine/folder_view.dart';
import 'package:ronet_engine/localStorage/storage.dart';

class Start extends StatefulWidget{
  List items = [];


  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {

  chooseProject(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Folder_view() ));
  }

  @override
  void initState() {
    super.initState();
    initItems();
  }

  initItems() async {
    List items = await read_data("history.txt");
    setState(() {
      widget.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(0),
        )),
        title: const Text("Создать проект", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Start_card(image: "assets/add-folder.png", label: "Создать проект", onClick : (){}),
                const SizedBox(height: 20),
                Start_card(image: "assets/folder.png", label: "Открыть проект", onClick: chooseProject)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text("Последняя активность:", style: Theme.of(context).textTheme.bodyLarge),
                Container(
                  height: 160,
                  width: 300,
                  child: ListView.builder(
                      itemCount: widget.items.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                        return TextButton(
                          onPressed: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SizedBox(
                                height: 20,
                                width: 300,
                                child: Text(widget.items[index], overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge)
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ]
        )
      ),
    );
  }
}