import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_application/app_cubit/Social_cubit.dart';
import 'package:social_application/app_cubit/social_states.dart';
import 'package:social_application/models/message_model.dart';
import 'package:social_application/models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messageController = TextEditingController();
  SocialUserModel userModel;
  ChatDetailsScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context)
          .getMessages(receiverId: userModel.uId.toString());
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(width: 15),
                    Text('${userModel.name}'),
                  ])),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message = SocialCubit.get(context).messages[index];
                              if( SocialCubit.get(context).userModel!.uId == message.senderId ){
                                return buildMyMessage(message);
                              }
                              return buildMessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                            itemCount: SocialCubit.get(context).messages.length),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here...',
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.blue,
                              width: 1,
                            ),
                            MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    receiverId:
                                    userModel.uId.toString(),
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                              },
                              child: Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          });
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            child: Text('${model.text}')),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.blue.withOpacity(.2),
            ),
            child: Text('${model.text}')),
      );
}
