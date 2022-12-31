import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
import '/config/app_router.dart';
import '/config/theme.dart';
import '/screens/screens.dart';
import '/models/models.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => SwipeBloc()
              ..add(
                LoadUsers(
                  users: User.users.where((user) => user.id != 1).toList(),
                ),
              ),
          ),
          BlocProvider(
            create: (_) => ImagesBloc(
              databaseRepository: DatabaseRepository(),
            )..add(
                LoadImages(),
              ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: ((context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "DATINGO",
              theme: theme(),
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute: OnboardingScreen.routeName,
            );
          }),
        ),
      ),
    );
  }
}
