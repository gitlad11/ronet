import 'package:flutter/material.dart';
import 'package:ronet_engine/components/navbar_item.dart';

class Navbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
          color: const Color(0xFF313131)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Navbar_item(title: "Проект"),
          Navbar_item(title: "Отладчик"),
          Navbar_item(title: "Помощь"),
        ],
      ),
    );
  }
}