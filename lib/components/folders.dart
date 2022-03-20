import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Folders extends StatefulWidget{

  @override
  Folders_state createState() => Folders_state();
}

class Folders_state extends State<Folders>{
  bool drag = false;
  double resized = 230.0;

  on_drag(size){
    if(size < 80.0 && size > 600.0){
      setState(() {
        resized = size;
      });
  }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height - 40,
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
              height: MediaQuery.of(context).size.height - 40,
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
                      child: Text("D:/cms-lichi", style: Theme.of(context).textTheme.labelLarge)
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
                  print(event.globalPosition.dx);
                  on_drag(event.globalPosition.dx);
                }
              },
              onTapDown: (_){
                setState(() {
                  drag = true;
                });
                print(_.globalPosition.dx);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: Container(
                  width: 6,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
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