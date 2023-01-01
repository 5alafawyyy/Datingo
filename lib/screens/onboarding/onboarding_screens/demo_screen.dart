import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';

class Demographics extends StatelessWidget {
  final TabController tabController;

  const Demographics({
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
                        text: 'What\'s Your Gender?',
                      ),
                      SizedBox(height: 10.0.h),
                      CustomCheckbox(
                        text: 'MALE',
                        value: state.user.gender == 'Male',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(gender: 'Male'),
                                ),
                              );
                        },
                      ),
                      CustomCheckbox(
                        text: 'FEMALE',
                        value: state.user.gender == 'Female',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(gender: 'Female'),
                                ),
                              );
                        },
                      ),
                      SizedBox(height: 0.08.sh),
                      const CustomTextHeader(
                        text: 'What\'s Your Age?',
                      ),
                      CustomTextField(
                        hint: 'ENTER YOUR AGE',
                        onChanged: (age) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(
                                    age: int.parse(age),
                                  ),
                                ),
                              );
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 6,
                        currentStep: 3,
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
