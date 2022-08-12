import 'package:flutter/material.dart';

class ClickableColumn extends StatelessWidget {
  final List<Widget> children;
  final void Function()? onClick;

  const ClickableColumn({Key? key, required this.children, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.white,
          child: InkWell(

            splashColor: Colors.greenAccent,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onClick,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}
