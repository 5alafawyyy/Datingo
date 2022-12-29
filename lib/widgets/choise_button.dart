import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiseButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final bool hasGradient;
  final IconData icon;

  const ChoiseButton({
    super.key,
    this.width = 60,
    this.height = 60,
    this.size = 25,
    required this.color,
    this.hasGradient = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.r,
      width: width.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        gradient: hasGradient
            ? LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ],
              )
            : const LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 4.0,
            blurRadius: 4.0,
            offset: const Offset(3, 3),
          )
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: size.r,
      ),
    );
  }
}
