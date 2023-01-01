import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class EmailVerification extends StatelessWidget {
  final TabController tabController;

  const EmailVerification({
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextHeader(
                  text: 'Did You Get The Verification Code?',
                ),
                SizedBox(height: 20.0.h),
                CustomTextField(
                  hint: 'ENTER YOUR CODE',
                  onChanged: (code) {
                    // context.read<OnboardingBloc>().add(
                    //             UpdateUser(
                    //               user: state.user.copyWith(gender: 'Female'),
                    //             ),
                    //           );
                  },
                ),
              ],
            ),
            Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 2,
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
