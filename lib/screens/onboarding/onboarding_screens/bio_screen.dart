import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
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
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
        if (state is OnboardingLoaded) {
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
                        text: 'Describe Yourself a Bit',
                      ),
                      SizedBox(height: 10.0.h),
                      CustomTextField(
                        hint: 'Type Your BIO',
                        onChanged: (bio) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(bio: bio),
                                ),
                              );
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 0.08.sh),
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
                        unselectedColor:
                            Theme.of(context).colorScheme.secondary,
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
        } else {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
      },
    );
  }
}
