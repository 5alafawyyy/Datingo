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
    final controller = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        height: 0.88.sh,
        padding: EdgeInsets.symmetric(
          horizontal: 30.0.w,
          vertical: 20.h,
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
                SizedBox(height: 0.08.sh),
                const CustomTextHeader(
                  text: 'What\'s Your Age?',
                ),
                CustomTextField(
                  hint: 'ENTER YOUR AGE',
                  controller: controller,
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
      ),
    );
  }
}
