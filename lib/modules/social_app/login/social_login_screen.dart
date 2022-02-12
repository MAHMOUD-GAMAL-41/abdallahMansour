import 'package:ex2/layout/social_app/social_layout.dart';
import 'package:ex2/modules/social_app/login/social_login_cubit/login_cubit.dart';
import 'package:ex2/modules/social_app/login/social_login_cubit/states.dart';
import 'package:ex2/modules/social_app/register/register_screen.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:ex2/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSocialScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState)
            {
              CacheHelper.saveData(key: 'uID', value: state.uID).then((value) {
                navigateAndFinish(context, SocialLayout());
              });
            }
        },

        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: Formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'login now to communicate with friends ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey[500]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Email Address';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Email Address'),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          onTap: () {
                            if (Formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Password'),
                            suffixIcon: IconButton(
                                visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                onPressed: () {
                                  SocialLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: SocialLoginCubit.get(context).isPassword
                                    ? Icon(
                                  Icons.visibility_outlined,
                                )
                                    : Icon(Icons.visibility_off_outlined)),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        state is! SocialLoginLoadState
                            ? defaultButton(
                          text: 'login',
                          function: () {
                            if (Formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        )
                            : Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                function: () {
                                   navigateAndFinish(context, RegisterSocialScreen());
                                },
                                text: 'register'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
