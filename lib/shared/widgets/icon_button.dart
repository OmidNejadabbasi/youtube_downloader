import 'package:flutter/material.dart';

class NIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? rippleColor;
  final double iconSize;

  const NIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconColor = Colors.black87,
    this.rippleColor,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
      onTap: onPressed,
      customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      splashColor: rippleColor ?? Colors.tealAccent,
    );
  }
}
