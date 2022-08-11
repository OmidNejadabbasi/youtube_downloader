import 'package:flutter/material.dart';

class ClickableColumn extends StatelessWidget {
  List<Widget> children;

  ClickableColumn({Key? key, required this.children}) : super(key: key);

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
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
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
