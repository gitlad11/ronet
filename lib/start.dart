import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ronet_engine/components/start_card.dart';
import 'package:ronet_engine/folder_view.dart';

class Start extends StatefulWidget{

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {

  chooseProject(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Folder_view() ));
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
                Text("Последняя активность:", style: Theme.of(context).textTheme.bodyLarge)
              ],
            )
          ]
        )
      ),
    );
  }
}