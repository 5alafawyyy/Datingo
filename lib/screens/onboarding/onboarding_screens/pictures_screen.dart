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
                      return Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                    if (state is ImagesLoaded) {
                      int imagesCount = state.imageUrls.length;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: GridView.builder(
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.66,
                          ),
                          itemBuilder: ((context, index) {
                            return (imagesCount > index)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[index],
                                  )
                                : const CustomImageContainer();
                          }),
                        ),
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
