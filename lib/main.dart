import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/screens/Social_screen.dart';
import 'package:social_application/screens/login/login_screen.dart';
import 'package:social_application/shared_preference/cash_helper.dart';
import 'app_cubit/Social_cubit.dart';
import 'app_cubit/blocobserver.dart';
import 'componants/constans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  uId = CashHelper.getData(key: 'uId');
  print(uId);
  Widget widget;
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
