import 'package:datingo/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/screens.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasAction;
  // final void Function()? profileOnPressed;
  // final void Function()? messageOnPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasAction = true,
    // this.profileOnPressed,
    // this.messageOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName,
                  ModalRoute.withName(HomeScreen.routeName),
                );
              },
              child: SvgPicture.asset(
                'assets/logo.svg',
                height: 40.h,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
      ),
      actions: hasAction
          ? [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    MatchesScreen.routeName,
                    arguments: context.read<AuthBloc>().state.user,
                  );
                },
                icon: const Icon(Icons.message),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ProfileScreen.routeName,
                    arguments: context.read<AuthBloc>().state.user,
                  );
                },
                icon: const Icon(Icons.person),
                color: Theme.of(context).primaryColor,
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0.h);
}
