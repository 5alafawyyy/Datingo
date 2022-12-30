import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool?)? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).primaryColor,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
