import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_application/screens/newpost_screen/new_post.dart';

import '../app_cubit/Social_cubit.dart';
import '../app_cubit/social_states.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
      if (state is SocialAddPostState) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPostScreen(),
            ));
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      return  Scaffold(
        appBar:  AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
          iconTheme: IconThemeData(color: Colors.black, size: 25),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(IconBroken.Notification),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(IconBroken.Search),
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(color: Colors.blue),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedFontSize: 15,
          unselectedFontSize: 15,
          backgroundColor: Colors.white,
          iconSize: 30,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 10,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            cubit.changeBottomNavBar(index);
          },
          items: cubit.bottomItems ,
        ),
      );
    });
  }
}
