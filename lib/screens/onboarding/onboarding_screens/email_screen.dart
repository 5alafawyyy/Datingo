import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../cubits/signup/signup_cubit.dart';
import '../widgets/widgets.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
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
                      text: 'What\'s Your Email Address?',
                    ),
                    SizedBox(height: 20.0.h),
                    CustomTextField(
                      hint: 'ENTER YOUR EMAIL',
                      onChanged: (value) {
                        context.read<SignupCubit>().emailChanged(value);
                        if (kDebugMode) {
                          print(state.email);
                        }
                      },
                    ),
                    SizedBox(height: 0.08.sh),
                    const CustomTextHeader(
                      text: 'Type a Password',
                    ),
                    SizedBox(height: 20.0.h),
                    CustomTextField(
                      hint: 'ENTER YOUR PASSWORD',
                      onChanged: (value) {
                        context.read<SignupCubit>().passwordChanged(value);
                        if (kDebugMode) {
                          print(state.password);
                        }
                      },
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
          ),
        );
      },
    );
  }
}
