import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';
import '../../../widgets/widgets.dart';

class Biography extends StatelessWidget {
  final TabController tabController;

  const Biography({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 50.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextHeader(
                text: 'Describe Yourself a Bit',
              ),
              SizedBox(height: 10.0.h),
              const CustomTextField(hint: 'Type Your BIO'),
              SizedBox(height: 80.0.h),
              const CustomTextHeader(
                text: 'What Do You Like?',
              ),
              Row(
                children: const [
                  CustomTextContainer(text: 'MUSIC'),
                  CustomTextContainer(text: 'PROGRAMMING'),
                  CustomTextContainer(text: 'Politics'),
                ],
              ),
              Row(
                children: const [
                  CustomTextContainer(text: 'NATURE'),
                  CustomTextContainer(text: 'HIKING'),
                  CustomTextContainer(text: 'FOOTBALL'),
                  CustomTextContainer(text: 'ART'),
                ],
              ),
              Row(
                children: const [
                  CustomTextContainer(text: 'ART'),
                  CustomTextContainer(text: 'MUSIC'),
                  CustomTextContainer(text: 'HIKING'),
                  CustomTextContainer(text: 'MUSIC'),
                ],
              ),
            ],
          ),
           Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 5,
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
