import 'package:ex2/layout/shop_app/shop_layout.dart';
import 'package:ex2/modules/shop_app/login/shop_login_cubit/login_cubit.dart';
import 'package:ex2/modules/shop_app/login/shop_login_cubit/states.dart';
import 'package:ex2/modules/shop_app/register/register_screen.dart';
import 'package:ex2/shared/components/constants.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:ex2/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopModel.status!) {
              print(state.shopModel.message);
              print(state.shopModel.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.shopModel.data!.token)
                  .then((value) {
                    token= state.shopModel.data!.token!;
                    navigateAndFinish(context, ShopLayout());
                  });
            } else {
              print(state.shopModel.message);
              showToast(
                  text: state.shopModel.message!, state: ToastStates.ERROR);
            }
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
                          'login now to browse our hot offers',
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
                              ShopLoginCubit.get(context).userLogin(
                                  Email: emailController.text,
                                  Password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Password'),
                            suffixIcon: IconButton(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                onPressed: () {
                                  ShopLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: ShopLoginCubit.get(context).isPassword
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
                        state is! ShopLoginLoadState
                            ? defaultButton(
                                text: 'login',
                                function: () {
                                  if (Formkey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        Email: emailController.text,
                                        Password: passwordController.text);
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
                                  navigateAndFinish(context, RegisterScreen());
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
