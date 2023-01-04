import 'package:datingo/blocs/blocs.dart';
import 'package:datingo/cubits/signup/signup_cubit.dart';
import 'package:datingo/models/models.dart';
import 'package:datingo/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;

  final String text;
  final void function;

  const CustomButton({
    Key? key,
    required this.tabController,
    this.text = 'START',
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.06.sh,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (tabController.index == 6) {
              Navigator.pushNamed(
                context,
                HomeScreen.routeName,
              );
            } else {
              tabController.animateTo(tabController.index + 1);
            }
            if (tabController.index == 2) {
              await context.read<SignupCubit>().signupWithCredentials();

              User user = User(
                id: context.read<SignupCubit>().state.user!.uid,
                name: '',
                age: 0,
                gender: '',
                imageUrls: [],
                interests: [],
                bio: '',
                jobTitle: '',
                location: Location.initialLocation,
                swipeLeft: [],
                swipeRight: [],
                matches: [],
              );

              context.read<OnboardingBloc>().add(
                    StartOnboarding(
                      user: user,
                    ),
                  );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
