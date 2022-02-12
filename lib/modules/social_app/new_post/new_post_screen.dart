import 'package:ex2/layout/social_app/cubit/social_cubit.dart';
import 'package:ex2/layout/social_app/cubit/social_states.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:ex2/shared/components/social_components.dart';
import 'package:ex2/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create post',
            actions: [
              defaultTextButton(
                  function: () {
                    if (socialCubit.get(context).postImage == null) {
                      socialCubit.get(context).createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      socialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  text: 'Post')
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    width: 5,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Mahmoud Gamal',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                 if (socialCubit.get(context).postImage != null)
                   Stack(
                     alignment: AlignmentDirectional.bottomEnd,
                     children: [
                       Container(
                         width: double.infinity,
                         height: 140,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(4),
                             image: DecorationImage(
                               image:
                                   FileImage(socialCubit.get(context).postImage!),
                               fit: BoxFit.cover,
                             )),
                       ),
                       IconButton(
                           color: Colors.black,
                           onPressed: () {
                             socialCubit.get(context).removePostImage();
                           },
                           icon: Icon(
                             Icons.close,
                             size: 20,
                           ))
                     ],

                   ),

                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          socialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add Photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# Tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
