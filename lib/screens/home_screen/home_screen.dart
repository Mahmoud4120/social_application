import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_application/app_cubit/Social_cubit.dart';
import 'package:social_application/app_cubit/social_states.dart';

import '../../models/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty && cubit.userModel != null,
          builder:(context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.all(10),
                    child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-photo/html-system-websites-collage-design_23-2150432963.jpg?w=740'),
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Communicate with friends',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ]),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => buildPostItem(cubit.posts[index] , context ,index),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: cubit.posts.length,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ) ;
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ) ;
      },
    );
  }

  Widget buildPostItem(PostModel model , context , index) => Card(
        color: Colors.white,
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.image}'),),
              SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 1.2,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                maxLines: 3,
                '${model.text}',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                            child: Text(
                              '#software_developer',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                            child: Text(
                              '#flutter',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Container(
                width: double.infinity,
                height: 150,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${model.postImage}'
                      ),
                    )
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${SocialCubit.get(context).likes[index]}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              IconBroken.Chat,
                              color: Colors.grey,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text('0 comment'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 1.2,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(children: [
                        CircleAvatar(
                            radius: 17,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel?.image}'
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'write a comment ...',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                      onTap: () {},
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                          },
                          child: Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          )),
                      SizedBox(
                        width: 2,
                      ),
                      Text('like'),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
}
