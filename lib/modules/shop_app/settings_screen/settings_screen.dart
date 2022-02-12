import 'package:ex2/layout/shop_app/cubit/States.dart';
import 'package:ex2/layout/shop_app/cubit/cubit.dart';
import 'package:ex2/shared/components/constants.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class settingsScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          phoneController.text = model.data!.phone!;
          emailController.text = model.data!.email!;
          return ShopCubit.get(context).userModel != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: Formkey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserDataState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              'name must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Name'),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              'Email must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Email Address'),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              'Phone must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Phone'),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                            function: () {
                              if (Formkey.currentState!.validate())
                                ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                );
                            },
                            text: 'Update'),
                        SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                            function: () {
                              signOut(context);
                            },
                            text: 'Sign Out')
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
