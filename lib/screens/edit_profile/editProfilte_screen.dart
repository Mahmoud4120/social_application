import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_application/componants/componant.dart';

import '../../app_cubit/Social_cubit.dart';
import '../../app_cubit/social_states.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          nameController.text = userModel!.name!;
          bioController.text = userModel.bio!;
          phoneController.text = userModel.phone!;
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        phone: phoneController.text,
                        bio: bioController.text,
                        name: nameController.text,
                      );
                    },
                    child: Text('UPDATE ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ))),
                SizedBox(
                  width: 6,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is UserUpdateLoadingStates)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: coverImage == null
                                              ? NetworkImage(
                                                  '${userModel.cover}')
                                              : FileImage(coverImage))),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey,
                                        child: Icon(
                                          IconBroken.Camera,
                                          color: Colors.white,
                                        )))
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 62.7,
                                child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage('${userModel.image}')
                                        : FileImage(profileImage)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        IconBroken.Camera,
                                        color: Colors.white,
                                      )))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        );
                                      },
                                      child: Text(
                                        'Upload Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        );
                                      },
                                      child: Text(
                                        'Upload Cover',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ],
                            ))
                        ],
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      SizedBox(
                        height: 25,
                      ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Name must not be empty!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(IconBroken.User),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: bioController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' bio must not be empty!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Bio',
                          prefixIcon: Icon(IconBroken.Info_Circle),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' phone must not be empty!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(IconBroken.Calling),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
