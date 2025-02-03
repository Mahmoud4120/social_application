import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/screens/chat_details/chat%20detaila_screen.dart';

import '../../app_cubit/Social_cubit.dart';
import '../../app_cubit/social_states.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder:(context) =>  ListView.separated(
              itemBuilder: (context, index) => buildChatItem(cubit.users[index], context),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              itemCount: cubit.users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model ,context) => InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(userModel: model,),));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(width: 15),
            Text(
              '${model.name}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    ),
  );
}
