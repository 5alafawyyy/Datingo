import 'package:datingo/screens/onboarding/onboarding_screens/screens.dart';
import 'package:datingo/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/Onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => const OnboardingScreen()),
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
    Tab(text: 'Location'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: ((context) {
          final TabController tabController = DefaultTabController.of(context)!;
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
                Location(tabController: tabController),
              ],
            ),
          );
        }),
      ),
    );
  }
}
