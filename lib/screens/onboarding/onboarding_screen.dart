import 'package:datingo/cubits/signup/signup_cubit.dart';
import 'package:datingo/repositories/auth/base_auth_repository.dart';
import 'package:datingo/screens/onboarding/onboarding_screens/screens.dart';
import 'package:datingo/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/Onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => BlocProvider(
            create: (context) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
            child: const OnboardingScreen(),
          )),
    );
  }

  const OnboardingScreen({super.key});

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Email Verification'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: ((context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });

          return Scaffold(
            appBar: const CustomAppBar(
              title: 'DATINGO',
              hasAction: false,
            ),
            body: TabBarView(
              children: [
                Start(tabController: tabController),
                Email(tabController: tabController),
                EmailVerification(tabController: tabController),
                Demographics(tabController: tabController),
                Pictures(tabController: tabController),
                Biography(tabController: tabController),
              ],
            ),
          );
        }),
      ),
    );
  }
}
