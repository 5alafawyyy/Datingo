import 'package:datingo/blocs/auth/auth_bloc.dart';
import 'package:datingo/blocs/swipe/swipe_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/user_model.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: ((context) => const HomeScreen()),
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'DISCOVER',
        profileOnPressed: () {
          Navigator.pushNamed(context, ProfileScreen.routeName,
              arguments: User.users[0],);
        },
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is SwipeLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onDoubleTap: () {
                      Navigator.pushNamed(
                        context,
                        UsersScreen.routeName,
                        arguments: state.users[0],
                      );
                    },
                    child: Draggable<User>(
                      data: state.users[0],
                      feedback: UserCard(user: state.users[0]),
                      childWhenDragging: (state.users.length > 1)
                          ? UserCard(user: state.users[1])
                          : Container(),
                      onDragEnd: ((drag) {
                        if (drag.velocity.pixelsPerSecond.dx < 0) {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeLeft(user: state.users[0]));
                          if (kDebugMode) {
                            print('Swiped left');
                          }
                        } else {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeLeft(user: state.users[0]));
                          if (kDebugMode) {
                            print('Swiped right');
                          }
                        }
                      }),
                      child: UserCard(user: state.users[0]),
                    ),
                  ),

                  // Choises Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 50.0.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<SwipeBloc>()
                                .add(SwipeLeft(user: state.users[0]));
                            if (kDebugMode) {
                              print('Swiped left');
                            }
                          },
                          child: ChoiseButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.clear_rounded,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<SwipeBloc>()
                                .add(SwipeLeft(user: state.users[0]));
                            if (kDebugMode) {
                              print('Swiped right');
                            }
                          },
                          child: ChoiseButton(
                            height: 80.r,
                            width: 80.r,
                            size: 30.r,
                            color: Colors.white,
                            hasGradient: true,
                            icon: Icons.favorite,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: ChoiseButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icons.watch_later,
                          ),
                        ),
                      ],
                    ),
                  ),
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
