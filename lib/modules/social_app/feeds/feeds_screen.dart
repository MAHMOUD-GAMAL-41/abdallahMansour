import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ex2/layout/social_app/cubit/social_cubit.dart';
import 'package:ex2/layout/social_app/cubit/social_states.dart';
import 'package:ex2/models/social_app/post_model.dart';
import 'package:ex2/shared/styles/colors.dart';
import 'package:ex2/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: socialCubit.get(context).posts.length > 0 && socialCubit.get(context).userModel !=null ,
              builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Communicate with friends',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: Colors.white),
                                  ),
                                )
                              ]),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildPostItem(socialCubit.get(context).posts[index],context,index),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          itemCount:socialCubit.get(context).posts.length,
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) {});
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        '${model.image}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.4),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 14,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                " ${model.text}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#Flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if(model.postImage!='')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${model.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${socialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 18,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${socialCubit.get(context).comments[index]} Comments',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                '${socialCubit.get(context).userModel.image}'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Write a comment ... ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {
                        socialCubit.get(context).commentPost(socialCubit.get(context).postsID[index]);
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {

                      socialCubit.get(context).likePost(socialCubit.get(context).postsID[index]);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
