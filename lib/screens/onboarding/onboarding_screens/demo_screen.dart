import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class Demographics extends StatelessWidget {
  final TabController tabController;

  const Demographics({
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextHeader(
                text: 'What\'s Your Gender?',
              ),
              SizedBox(height: 10.0.h),
              CustomCheckbox(
                text: 'MALE',
                value: true,
                onChanged: (value) {},
              ),
              CustomCheckbox(
                text: 'FEMALE',
                value: false,
                onChanged: (value) {},
              ),
              SizedBox(height: 80.0.h),
              const CustomTextHeader(
                text: 'What\'s Your Age?',
              ),
              const CustomTextField(
                hint: 'ENTER YOUR AGE',
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 3,
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
