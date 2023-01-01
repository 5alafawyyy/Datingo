import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';

class Location extends StatelessWidget {
  final TabController tabController;

  const Location({
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
              height: 0.86.sh,
              padding: EdgeInsets.symmetric(
                horizontal: 30.0.w,
                vertical: 20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextHeader(
                        text: 'Where Are You?',
                      ),
                      SizedBox(height: 10.0.h),
                      CustomTextField(
                        hint: 'ENTER YOUR LOCATION',
                        onChanged: (location) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(location: location),
                                ),
                              );
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 6,
                        currentStep: 6,
                        selectedColor: Theme.of(context).primaryColor,
                        unselectedColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(height: 10.0.h),
                      CustomButton(
                        tabController: tabController,
                        text: 'DONE',
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
