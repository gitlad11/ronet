import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget{
  String type = 'text';
  Widget icon;
  late var go_back;
  late FocusNode focus;
  late TextEditingController controller;
  Input(this.type, this.icon, this.controller, this.focus, this.go_back);

  @override
  Input_state createState() => Input_state();
}

class Input_state extends State<Input>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List back_slash = widget.controller.text.split(r'\');
    List slash = widget.controller.text.split('/');
    back_slash.remove('');
    slash.remove('');

    return TextFieldContainer(
      child :  TextField(
        controller: widget.controller,
        focusNode : widget.focus,
        cursorColor: const Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon:
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: back_slash.length > 1 || slash.length > 1 ? GestureDetector(
                onTap: (){ widget.go_back(); },
                child: const Icon(
                  Icons.keyboard_backspace_outlined, size: 22, color: Color(0xFFE5E3E8),
                ),
              ) : widget.icon,
            ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  TextFieldContainer({
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          height: 45,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xFF383838),
            borderRadius: BorderRadius.circular(29),
          ),
          child: child,
        ),
      ],
    );
  }
}