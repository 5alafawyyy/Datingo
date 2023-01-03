import 'package:datingo/screens/chat/chat_screen.dart';
import 'package:datingo/widgets/custom_appbar.dart';
import 'package:datingo/widgets/custom_elevated_button.dart';
import 'package:datingo/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/M atches';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => BlocProvider<MatchBloc>(
            create: (context) => MatchBloc(
              databaseRepository: context.read<DatabaseRepository>(),
            )..add(
                LoadMatches(
                  user: context.read<AuthBloc>().state.user!,
                ),
              ),
            child: const MatchesScreen(),
          )),
    );
  }

  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'MATCHES'),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoadingState) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is MatchLoadedState) {
            final inactiveMatches =
                state.matches.where((match) => match.chat == null).toList();
            final activeMatches =
                state.matches.where((match) => match.chat != null).toList();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Likes',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    MatchesList(inactiveMatches: inactiveMatches),
                    SizedBox(height: 15.h),
                    Text('Your Chats',
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 5.h),
                    ChatsList(activeMatches: activeMatches),
                  ],
                ),
              ),
            );
          } else if (state is MatchUnavailableState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No matches Yet.',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 20.0.h),
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Back To Swiping'.toUpperCase(),
                    beginColor: Theme.of(context).colorScheme.secondary,
                    endColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}

class ChatsList extends StatelessWidget {
  const ChatsList({
    Key? key,
    required this.activeMatches,
  }) : super(key: key);

  final List<Match> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: activeMatches.length,
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ChatScreen.routeName,
              arguments: activeMatches[index],
            );
          },
          child: Row(
            children: [
              UserImage.small(
                height: 70.w,
                width: 70.w,
                url: activeMatches[index].matchedUser.imageUrls[0],
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeMatches[index].matchedUser.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    activeMatches[index].chat![0].messages[0].message,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    activeMatches[index].chat![0].messages[0].timeString,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
            ],
          ),
        );
      }),
      separatorBuilder: ((context, index) {
        return SizedBox(height: 10.h);
      }),
    );
  }
}

class MatchesList extends StatelessWidget {
  const MatchesList({
    Key? key,
    required this.inactiveMatches,
  }) : super(key: key);

  final List<Match> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: inactiveMatches.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              UserImage.small(
                height: 70.w,
                width: 70.w,
                url: inactiveMatches[index].matchedUser.imageUrls[0],
              ),
              SizedBox(height: 10.h),
              Text(
                inactiveMatches[index].matchedUser.name,
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          );
        }),
        separatorBuilder: ((context, index) {
          return SizedBox(width: 10.w);
        }),
      ),
    );
  }
}
