import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ex2/layout/social_app/cubit/social_cubit.dart';
import 'package:ex2/layout/social_app/cubit/social_states.dart';
import 'package:ex2/models/social_app/message_model.dart';
import 'package:ex2/models/social_app/social_user_model.dart';
import 'package:ex2/shared/styles/colors.dart';
import 'package:ex2/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  socialUserModel? userModel;
  var messageController = TextEditingController();

  ChatDetailsScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      socialCubit.get(context).getMessages(receiverId: userModel!.uId!);
      return BlocConsumer<socialCubit, SocialStates>(
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('${userModel!.name}')
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: socialCubit.get(context).messages.length > 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context,index)
                            {
                              var message=socialCubit.get(context).messages[index];
                              if(socialCubit.get(context).userModel.uId==message.senderId)
                                return buildSenderMessage(message);
                              else
                                return buildReceiverMessage(message);
                            },
                            separatorBuilder: (context,index)=>SizedBox(height: 15,),
                            itemCount: socialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadiusDirectional.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here ... '),
                              )),
                              Container(
                                height: 40,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    socialCubit.get(context).sendMessage(
                                          receiverId: userModel!.uId!,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text,
                                        );
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                  minWidth: 1.0,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          listener: (context, state) {});
    });
  }

  Widget buildReceiverMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: Colors.grey[300],
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          )),
          child: Text('${model.text}'),
        ),
      );

  Widget buildSenderMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: defaultColor.withOpacity(.2),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          )),
          child: Text('${model.text}'),
        ),
      );
}
