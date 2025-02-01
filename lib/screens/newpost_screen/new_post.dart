import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_application/app_cubit/Social_cubit.dart';
import 'package:social_application/app_cubit/social_states.dart';

import '../../componants/componant.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
            appBar:
                defaultAppBar(context: context, title: 'Create Post', actions: [
              TextButton(
                  onPressed: () {
                    if (cubit.postImage != null) {
                      // photo exist in new post
                      cubit.uploadPostImage(
                          dateTime: DateTime.now().toString(),
                          text: textController.text);
                    } else {
                      cubit.createPost(
                          dateTime: DateTime.now().toString(),
                          text: textController.text);
                    }
                  },
                  child: Text(
                    'POST',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ]),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState)
                      LinearProgressIndicator(
                        color: Colors.blue,
                      ),
                    if (state is SocialCreatePostLoadingState)
                      SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 27,
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/premium-photo/medium-shot-woman-having-fun-party_23-2151108195.jpg?ga=GA1.1.723891102.1737950084')),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            'Mahmoud Abdelmoniem',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'What is in your mind ...',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(cubit.postImage!))),
                          ),
                          IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                              },
                              icon: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                cubit.getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconBroken.Image,
                                      color: Colors.blue, size: 25),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'add photo',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              '# tags',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
