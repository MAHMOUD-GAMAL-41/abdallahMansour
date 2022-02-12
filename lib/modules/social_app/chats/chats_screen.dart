import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ex2/layout/social_app/cubit/social_cubit.dart';
import 'package:ex2/layout/social_app/cubit/social_states.dart';
import 'package:ex2/models/social_app/social_user_model.dart';
import 'package:ex2/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, SocialStates>(
        builder: (context, state) => ConditionalBuilder(condition:socialCubit.get(context).users.length>0 , builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics() ,
            itemBuilder: (context, index) => buildChatItem(socialCubit.get(context).users[index],context ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: socialCubit.get(context).users.length), fallback: (context)=>Center(child: CircularProgressIndicator(),)),
        listener: (context, state) {});
  }

  Widget buildChatItem(socialUserModel model,context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '${model.name}',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
    ),
  );
}
