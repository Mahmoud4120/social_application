import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../componants/componant.dart';
import '../../shared_preference/cash_helper.dart';
import '../Social_screen.dart';
import '../register/register_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessStates) {
            CashHelper.saveData(key: 'uId', value: state.uId)
                .then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
              showToast(message: 'Login Successfully', state: ToastState.success);
            });
          } else if (state is LoginErrorStates) {
            showToast(message: state.error, state: ToastState.error);
          }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            body: Scaffold(
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
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Login now to communicate with friends'),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email address must not be empty!';
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
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: cubit.obscureText,
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
                                    cubit.changeObscureText(); // تغيير الحالة
                                  },
                                  icon: Icon(cubit.suffix),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingStates,
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
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 21),
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      })),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account ? ',
                                  style: TextStyle(fontSize: 15),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen()));
                                    },
                                    child: Text(
                                      'Register Now',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ))
                              ],
                            ),
                          ]),
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
