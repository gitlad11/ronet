import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronet_engine/components/input.dart';
import 'package:ronet_engine/providers/console_provider.dart';
import 'package:ronet_engine/providers/size_provider.dart';
import 'package:ronet_engine/handlers/stdin_console.dart';

class Console extends StatefulWidget{
  List items = [];

  @override
  Console_state createState() => Console_state();
}

class Console_state extends State<Console>{
  bool drag = false;
  double resized = 230.0;

  ScrollController listScrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();

  on_drag(size){
    if(size < MediaQuery.of(context).size.height - 100.0){
      var resize = MediaQuery.of(context).size.height - size;
      setState(() {
        resized = resize;
      });
    } else {
      setState(() {
        resized = 101.0;
      });
    }
    Provider.of<Size_provider>(context, listen: false).setSideHeight(size);
  }

  on_command() async {
    if(controller.text != "clear"){
      var result = await stdin_console(controller.text);
      await Provider.of<Console_provider>(context, listen: false ).setItem("> " + controller.text);
      await Provider.of<Console_provider>(context, listen: false).setItem(result);
      if (listScrollController.hasClients) {
        final position = listScrollController.position.maxScrollExtent;
        listScrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } else {
      await Provider.of<Console_provider>(context, listen: false).clearItems();
    }
    controller.clear();
  }

  @override
  void dispose() {
    Provider.of<Console_provider>(context, listen: false).clearItems();
    controller.dispose();
    listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Console_provider>(
      builder: (context, console_provider, snapshot) {
        return Container(
          height: resized,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    on_drag(event.globalPosition.dy);
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
                  cursor: SystemMouseCursors.resizeRow,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 6,
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
              ),
              Container(
                height: resized - 79,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.only(top: 3, left: 3, right: 3),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: ListView.builder(
                  controller: listScrollController,
                  itemCount: console_provider.items.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                      return Text(console_provider.items[index], style: Theme.of(context).textTheme.bodyMedium);
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 3, right: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor
                  ),
                  height: 62,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Stack(
                    children: [
                      Input("email", const Icon(Icons.code), controller, focus, (){}),
                      Positioned(
                          right: 10,
                          top: 10,
                          child: GestureDetector(onTap: (){ on_command(); }, child: const Icon(Icons.send))
                      )
                    ],
                  )
              )
            ],
          ),
        );
      }
    );
  }
}