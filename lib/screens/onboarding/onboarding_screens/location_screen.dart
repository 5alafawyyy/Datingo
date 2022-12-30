import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Location extends StatelessWidget {
  final TabController tabController;

  const Location({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 0.88.sh,
        padding: EdgeInsets.symmetric(
          horizontal: 30.0.w,
          vertical: 20.h,
        ),
        child: Container(),
      ),
    );
  }
}
