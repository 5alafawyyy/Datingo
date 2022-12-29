import 'package:datingo/screens/chat/chat_screen.dart';
import 'package:datingo/widgets/custom_appbar.dart';
import 'package:datingo/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/models.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/Matches';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => const MatchesScreen()),
    );
  }

  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'MATCHES'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Likes', style: Theme.of(context).textTheme.headline4),
              SizedBox(
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
              ),
              SizedBox(height: 15.h),
              Text('Your Chats', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 5.h),
              ListView.separated(
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
                              activeMatches[index]
                                  .chat![0]
                                  .messages[0]
                                  .timeString,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
