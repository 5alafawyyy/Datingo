import 'package:datingo/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0.w,
        vertical: 50.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 200.0.h,
                width: 200.0.w,
                child: SvgPicture.asset('assets/couple.svg'),
              ),
              SizedBox(height: 40.0.h),
              Text(
                'Welcome To Arrow',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 20.0.h),
              Text(
                'Lorem ipsum dolor sit amet, augue condimentum, lacus condimentum varius, veniam ipsum tortor condimentum ac tortor, netus blandit mi libero, sit dis ornare. Iaculis orci vehicula a enim diam sit, libero mauris iaculis rutrum, elit lacus sed in diam.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      height: 1.8,
                    ),
              ),
            ],
          ),
          CustomButton(
            tabController: tabController,
          ),
        ],
      ),
    );
  }
}
