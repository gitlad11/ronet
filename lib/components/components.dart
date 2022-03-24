import 'package:flutter/material.dart';
import 'package:ronet_engine/components/component.dart';
import 'package:ronet_engine/components/toolTip.dart';
import 'package:ronet_engine/components/component_view.dart';

class Components extends StatefulWidget{
  List items = [{ "name" : "Шейдеры" }];
  List values =  [ { "name" : "opacity", "value" : '1.0' }, { "name" : "opacity", "value" : '1.0' } ];
  String name = 'item name';

  @override
  Components_state createState() => Components_state();
}

class Components_state extends State<Components>{
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
      height: MediaQuery.of(context).size.height - 45,
      width: 340,
      padding: const EdgeInsets.all(8),
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
      child: Column(
        children: [
          Component_view(),
          Container(

              width: double.infinity,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)

              ),
              child: Stack(
                children: [
                  rename ? Container(
                    height : 20,
                    width: 180,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: widget.name,
                      ),
                    ),
                  )  : Text(widget.name, style: Theme.of(context).textTheme.labelLarge),
                  Positioned(
                    right: 0,
                    top: 0,
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
          ),
          const SizedBox( height: 20 ),
          Container(
            width: 340,
            child: ListView.builder(
              itemCount: widget.items.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Component(label: widget.items[index]['name'], items: widget.values);
              }
            ),
          )
        ],
      ),
    );
  }
}