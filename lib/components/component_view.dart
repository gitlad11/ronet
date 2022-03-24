import 'package:flutter/material.dart';
import 'package:ronet_engine/components/toolTip.dart';
import 'package:ronet_engine/components/component_view_item.dart';

class Component_view extends StatefulWidget{
  List items = [{ "name" : "component1" }, { "name" : "component2" }, { "name" : "component3" }];
  String name = 'name';

  @override
  Component_view_state createState() => Component_view_state();
}

class Component_view_state extends State<Component_view>{
  bool rename = false;
  int toolTip = 999;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)

                ),
                child: Row( children: [
                  Text("Сцена: ", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(width: 10),
                  rename ? Container(
                      height: 23,
                      width: 120,
                      child: TextField( decoration: InputDecoration( hintText: widget.name ), )
                  ) : Text("scene1", style: Theme.of(context).textTheme.labelMedium)
                ]),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: MouseRegion(
                  onEnter: (_){
                    setState(() {
                      toolTip = 1;
                    });
                  },
                  onExit: (_){
                    setState(() {
                      toolTip = 999;
                    });
                  },
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        rename = !rename;
                      });
                    },
                    child: const Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                ),
              ),
              Positioned(
                  right: 20,
                  top: 5,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: toolTip == 1 ? 1 : 0,
                    child: ToolTip(
                      label: "Переименовать",
                    ),
                  )
              )
            ],
          ),
          widget.items.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: widget.items.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Component_view_item( label: widget.items[index]['name'] );
                }),
            ),
          ) : Center( child: Text("Сцена пуста.", style : Theme.of(context).textTheme.bodyMedium)),
          Padding(
            padding: const EdgeInsets.only(bottom:  6.0),
            child: Divider(height: 4, color: Theme.of(context).scaffoldBackgroundColor),
          ),

        ],
      ),
    );
  }
}