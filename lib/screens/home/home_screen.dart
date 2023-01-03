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
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoadingState) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        } else if (state is SwipeLoadedState) {
          return SwipeLoadedHomeScreen(state: state);
        } else if (state is SwipeMatchedState) {
          // TODO: change this state with matched
          return SwipeMatchedHomeScreen(state: state);
        } else if (state is SwipeErrorState) {
          return const Scaffold(
            appBar: CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: Text('There aren\'t any more users.'),
            ),
          );
        } else {
          return const Scaffold(
            appBar: CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: Text('Something went wrong!'),
            ),
          );
        }
      },
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeLoadedState state;

  @override
  Widget build(BuildContext context) {
    int userCount = state.users.length;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DISCOVER',
      ),
      body: SingleChildScrollView(
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
                childWhenDragging: (userCount > 1)
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
      ),
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeMatchedState state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats, it\'s a match!',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 20.0.h),
            Text(
              'You and ${state.user.name} have liked each other!',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                        context.read<AuthBloc>().state.user!.imageUrls[0],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0.w),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0.h),
            CustomElevatedButton(
              onPressed: () {},
              text: 'Send a Message'.toUpperCase(),
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20.0.h),
            CustomElevatedButton(
              onPressed: () {
                context.read<SwipeBloc>().add(
                      LoadUsers(user: context.read<AuthBloc>().state.user!),
                    );
              },
              text: ' baCk to SwiPe'.toUpperCase(),
              beginColor: Theme.of(context).primaryColor,
              endColor: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
