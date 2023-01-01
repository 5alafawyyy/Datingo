import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/cubits.dart';
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
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SwipeBloc()
              ..add(
                LoadUsers(
                  users: User.users.where((user) => user.id != 1).toList(),
                ),
              ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(
              databaseRepository: DatabaseRepository(),
              storageRepository: StorageRepository(),
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
              initialRoute: SplashScreen.routeName,
            );
          }),
        ),
      ),
    );
  }
}
