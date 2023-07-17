import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkeybox_final/Cubit/auth_cubit/login_cubit/login_cubit.dart';
import 'package:monkeybox_final/Cubit/auth_cubit/register_cubit/register_cubit.dart';
import 'package:monkeybox_final/Cubit/get_user_cubit/get_user_cubit.dart';
import 'package:monkeybox_final/Cubit/histiry_cubit/history_cubit.dart';
import 'package:monkeybox_final/Cubit/logout_cubit/logout_cubit.dart';
import 'package:monkeybox_final/Cubit/theme_cubit/theme_cubit.dart';
import 'package:monkeybox_final/view/auth/Login&SignUp.dart';
import 'package:monkeybox_final/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Bloc_opserver.dart';
import 'Cubit/theme_cubit/theme_state.dart';
import 'controller/dio/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await initSharedPrefs();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => RegisterCubit()),
      BlocProvider(create: (_) => LoginCubit()),
      BlocProvider(create: (_) => GetUserCubit()),
      BlocProvider(create: (_) => LogoutCubit()),
      BlocProvider(create: (_) => HistoryCubit()),
    ],
    child: MyApp(),
  )));
}
Future<void> initSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDark', false);
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final ThemeCubit themeCubit = ThemeCubit();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => ThemeCubit()..initTheme(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
                home: AuthPage(),
              );
            },
          ),
        );
      },
    );
  }
}
