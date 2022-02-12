import 'dart:io';

import 'package:ex2/layout/social_app/cubit/social_cubit.dart';
import 'package:ex2/layout/social_app/cubit/social_states.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:ex2/shared/components/social_components.dart';
import 'package:ex2/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = socialCubit.get(context).userModel;
        var profileImage = socialCubit.get(context).profileImage;
        var coverImage = socialCubit.get(context).coverImage;
        bioController.text = userModel.bio!;
        nameController.text = userModel.name!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                function: () {
                  socialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'Update'),
            SizedBox(
              width: 10,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 200,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage('${userModel.cover}')
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(.7),
                                      radius: 20,
                                      child: IconButton(
                                          color: Colors.black,
                                          onPressed: () {
                                            socialCubit
                                                .get(context)
                                                .getCoverImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Camera,
                                            size: 20,
                                          ))),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, right: 0),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Colors.black.withOpacity(.7),
                                    radius: 18,
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          socialCubit
                                              .get(context)
                                              .getProfileImage();
                                        },
                                        icon: Icon(
                                          IconBroken.Camera,
                                          size: 18,
                                        ))),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  if (socialCubit.get(context).coverImage != null ||
                      socialCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (socialCubit.get(context).coverImage != null)
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      socialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    text: 'Upload Cover'),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                  height: 5,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                              ],
                            ),
                          )),
                        if (socialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      socialCubit
                                          .get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    },
                                    text: 'Upload Profile'),
                                if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                              ],
                            ),
                          )),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your Name ';
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Name'),
                        prefixIcon: Icon(IconBroken.User)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bioController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your Bio ';
                      }
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(IconBroken.Info_Circle),
                      border: OutlineInputBorder(),
                      label: Text('Bio'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter your Phone ';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Phone'),
                        prefixIcon: Icon(IconBroken.Call)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
