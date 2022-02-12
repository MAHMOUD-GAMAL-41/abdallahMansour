import 'package:ex2/layout/social_app/social_layout.dart';
import 'package:ex2/modules/social_app/login/social_login_screen.dart';
import 'package:ex2/modules/social_app/register/social_register_cubit/register_cubit.dart';
import 'package:ex2/modules/social_app/register/social_register_cubit/states.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSocialScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterErrorState)
            showToast(text: state.error.toString(), state: ToastStates.ERROR);
          if (state is SocialCreateUserSuccessState)
            navigateAndFinish(context, LoginSocialScreen());
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: Formkey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Register now to communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey[500]),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Name ';
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Name'),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Phone Number';
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Phone Address'),
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          SizedBox(
                            height: 25,
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
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            obscureText:
                                SocialRegisterCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                              suffixIcon: IconButton(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  onPressed: () {
                                    SocialRegisterCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: SocialRegisterCubit.get(context)
                                          .isPassword
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
                          state is! SocialRegisterLoadState
                              ? defaultButton(
                                  text: 'register',
                                  function: () {
                                    if (Formkey.currentState!.validate()) {
                                      SocialRegisterCubit.get(context)
                                          .userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
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
                              Text('You have an account'),
                              defaultTextButton(
                                  function: () {
                                    navigateAndFinish(
                                        context, LoginSocialScreen());
                                  },
                                  text: 'Login'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
