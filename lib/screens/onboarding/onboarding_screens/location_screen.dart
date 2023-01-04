import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';
import '../../../models/models.dart';

class LocationTab extends StatelessWidget {
  final TabController tabController;

  const LocationTab({
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
                  SizedBox(
                    height: 0.7.sh,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextHeader(
                          text: 'Where Are You?',
                        ),
                        SizedBox(height: 5.0.h),
                        CustomTextField(
                          hint: 'ENTER YOUR LOCATION',
                          onChanged: (value) {
                            Location location =
                                state.user.location.copyWith(name: value);
                           
                            context.read<OnboardingBloc>().add(
                                  UpdateUserLocation(
                                    location: location,
                                  ),
                                );
                          },
                          onFocusChanged: (hasFocus) {
                            if (hasFocus) {
                              return;
                            } else {
                              context.read<OnboardingBloc>().add(
                                    UpdateUserLocation(
                                      isUpdateComplete: true,
                                      location: state.user.location,
                                    ),
                                  );
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10.0.h),
                        Expanded(
                          child: GoogleMap(
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              context.read<OnboardingBloc>().add(
                                    UpdateUserLocation(
                                      controller: controller,
                                    ),
                                  );
                            },
                            initialCameraPosition: CameraPosition(
                              zoom: 10.0,
                              target: LatLng(
                                state.user.location.lat,
                                state.user.location.lon,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0.h),
                      ],
                    ),
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
