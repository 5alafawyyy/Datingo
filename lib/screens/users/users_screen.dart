import 'package:datingo/models/models.dart';
import 'package:datingo/widgets/choise_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => UsersScreen(
            user: user,
          )),
    );
  }

  const UsersScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.0.h),
                    child: Hero(
                      tag: 'user_image',
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user.imageUrls[0]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Theme.of(context).primaryColor,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ChoiseButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.clear_rounded,
                          ),
                          const ChoiseButton(
                            width: 80,
                            height: 80,
                            size: 30,
                            color: Colors.white,
                            hasGradient: true,
                            icon: Icons.favorite,
                          ),
                          ChoiseButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icons.watch_later,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name}, ${user.age}",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    user.jobTitle,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    user.bio,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          height: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  Text(
                    'Interests',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Row(
                    children: user.interests
                        .map((interest) => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w,
                                vertical: 5.0.h,
                              ),
                              margin: EdgeInsets.only(
                                right: 5.0.w,
                              ),
                              child: Center(
                                child: Text(
                                  interest,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ))
                        .toList()
                        .sublist(0, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
