import 'package:exercise_demo/comon/bloc/mybuttom_bloc.dart';
import 'package:flutter/material.dart';

///Code Thầy
class MyButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool enable;/// check điều kiện #2 để lock or unlock
  final VoidCallback onTap;

  const MyButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.red,
    this.enable = true,
    required this.onTap,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late MybuttomBloc myButtomBloc;
@override
  void initState() {
  myButtomBloc = MybuttomBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: myButtomBloc.streamButtom,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () {
            myButtomBloc.isLock(() {
              widget.onTap();
            });
          },
          child: Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (myButtomBloc.lock || !widget.enable)
                  ? Colors.grey[400]
                  : widget.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: widget.textColor, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
