import 'package:datingo/blocs/blocs.dart';
import 'package:datingo/models/models.dart';
import 'package:datingo/screens/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../repositories/repositories.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/Profile';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) {
        if (kDebugMode) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
        }
        return (BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.unauthenticated)
            ? const OnboardingScreen()
            : ProfileScreen(
                user: user,
              );
      }),
    );
  }

  final User user;
  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PROFILE',
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  UserImage.medium(
                    url: state.user.imageUrls[0],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.1),
                            Theme.of(context).primaryColor.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text(
                            state.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWithIcon(
                            title: 'Biography', icon: Icons.edit),
                        Text(
                          state.user.bio,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.5),
                        ),
                        const TitleWithIcon(
                            title: 'Pictures', icon: Icons.edit),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: state.user.imageUrls.isNotEmpty ? 125 : 0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.user.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: UserImage.small(
                                  width: 100,
                                  url: state.user.imageUrls[index],
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const TitleWithIcon(
                            title: 'Location', icon: Icons.edit),
                        Text(
                          state.user.location.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.5),
                        ),
                        const TitleWithIcon(
                            title: 'Interest', icon: Icons.edit),
                        Row(
                          children: [
                            // CustomTextContainer(text: state.user.interests[0]),
                            // CustomTextContainer(text: state.user.interests[1]),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            RepositoryProvider.of<AuthRepository>(context)
                                .signOut()
                                .then((value) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.routeName,
                                ModalRoute.withName(LoginScreen.routeName),
                              );
                            });
                          },
                          child: Center(
                            child: Text(
                              'Sign Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          },
        ),
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
      ],
    );
  }
}
