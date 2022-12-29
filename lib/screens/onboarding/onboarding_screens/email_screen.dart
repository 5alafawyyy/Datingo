import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0.w,
        vertical: 50.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const CustomTextHeader(
                text: 'What\'s Your Email Address?',
              ),
              SizedBox(height: 20.0.h),
              const CustomTextField(
                hint: 'ENTER YOUR EMAIL',
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 10.0.h),
              CustomButton(
                tabController: tabController,
                text: 'NEXT',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
