import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/images/images_bloc.dart';
import '../widgets/widgets.dart';
import '../../../widgets/widgets.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;

  const Pictures({
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
                  text: 'Add 2 or More Pictures',
                ),
                SizedBox(height: 10.0.h),
                BlocBuilder<ImagesBloc, ImagesState>(
                  builder: (context, state) {
                    if (state is ImagesLoading) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    if (state is ImagesLoaded) {
                      int imagesCount = state.imageUrls.length;
                      return Column(
                        children: [
                          Row(
                            children: [
                              (imagesCount > 0)
                                  ? CustomImageContainer(
                                      imageUrl: state.imageUrls[0],
                                    )
                                  : const CustomImageContainer(),
                              (imagesCount > 1)
                                  ? CustomImageContainer(
                                      imageUrl: state.imageUrls[1],
                                    )
                                  : const CustomImageContainer(),
                              (imagesCount > 2)
                                  ? CustomImageContainer(
                                      imageUrl: state.imageUrls[2],
                                    )
                                  : const CustomImageContainer(),
                            ],
                          ),
                          Row(
                            children: [
                              (imagesCount > 3)
                                  ? CustomImageContainer(
                                      imageUrl: state.imageUrls[3],
                                    )
                                  : const CustomImageContainer(),
                              (imagesCount > 4)
                                  ? CustomImageContainer(
                                      imageUrl: state.imageUrls[4],
                                    )
                                  : const CustomImageContainer(),
                              (imagesCount > 5)
                                  ? CustomImageContainer(
                                      imageUrl: state.imageUrls[5],
                                    )
                                  : const CustomImageContainer(),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('Something went wrong!'),
                      );
                    }
                  },
                ),
              ],
            ),
            Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 4,
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
