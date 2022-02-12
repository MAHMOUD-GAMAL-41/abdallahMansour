import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex2/layout/social_app/cubit/social_states.dart';
import 'package:ex2/models/social_app/message_model.dart';
import 'package:ex2/models/social_app/post_model.dart';
import 'package:ex2/models/social_app/social_user_model.dart';
import 'package:ex2/modules/social_app/chats/chats_screen.dart';
import 'package:ex2/modules/social_app/feeds/feeds_screen.dart';
import 'package:ex2/modules/social_app/new_post/new_post_screen.dart';
import 'package:ex2/modules/social_app/settings/settings_screen.dart';
import 'package:ex2/modules/social_app/users/users_screen.dart';
import 'package:ex2/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class socialCubit extends Cubit<SocialStates> {
  socialCubit() : super(SocialInitState());

  static socialCubit get(context) => BlocProvider.of(context);
  late socialUserModel userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      print(value.data());
      userModel = socialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    ;
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottonNavState());
    }
  }

  File?   profileImage;
  var pickerProfile = ImagePicker();

  Future getProfileImage() async {
    final PickedFile =
    await pickerProfile.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else
      print('No Image Selected');
    emit(SocialProfileImagePickedErrorState());
  }

  var pickerCover = ImagePicker();

  File? coverImage;

  Future getCoverImage() async {
    final PickedFile = await pickerCover.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      coverImage = File(PickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else
      print('No Image Selected');
    emit(SocialCoverImagePickedErrorState());
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //   emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? email,
    String? image,
    String? cover,
  }) {
    socialUserModel model = socialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: email ?? userModel.email,
        uId: userModel.uId,
        image: image ?? userModel.image,
        cover: cover ?? userModel.cover,
        password: userModel.password,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(
      model.toMap(),
    )
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;
  var pickerPostImage = ImagePicker();

  Future<void> getPostImage() async {
    final PickedFile =
    await pickerPostImage.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      postImage = File(PickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else
      print('No Image Selected');
    emit(SocialPostImagePickedErrorState());
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
      model.toMap(),
    )
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          posts = [];
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsID.add(element.id);
        }).catchError((error) {});

        element.reference.collection('comments').get().then((value) {
          posts = [];
          comments.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsID.add(element.id);
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'likes': true,
    }).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  void commentPost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('comments')
        .doc(userModel.uId)
        .set({
      'comments': true,
    }).then((value) {
      emit(SocialCommentPostsSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostsErrorState(error.toString()));
    });
  }

  List<socialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(socialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      receiverId: receiverId,
      dateTime: dateTime,
      senderId: userModel.uId,
    );


    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });


    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }


  List<MessageModel> messages = [];

  void getMessages({ required String receiverId,}) {
    FirebaseFirestore.instance.collection('users').doc(userModel.uId)
        .collection('chats').doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
    .snapshots()
        .listen((event)
    {
      messages=[];
      event.docs.forEach((element) { 
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());

    })
    ;
  }
}
