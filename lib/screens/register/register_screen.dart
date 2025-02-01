import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/screens/Social_screen.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessStates) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var registerCubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Register now to communicate with friends'),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'User Name must not be empty!';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: 'User Name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email address must not be empty !';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email Address',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller:
                                passwordController, // تأكد أنك تستخدم نفس الـ controller
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registerCubit
                                .obscureText, // يتم التحكم هنا بالحالة
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  registerCubit.changeObscureText();
                                },
                                icon: Icon(registerCubit.suffix),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone must not be empty!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingStates,
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                            builder: (context) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                width: double.infinity,
                                child: MaterialButton(
                                    child: Text(
                                      "REGISTER",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 21),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        registerCubit.userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                            name: nameController.text);

                                      }
                                    })),
                          ),
                        ]),
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
