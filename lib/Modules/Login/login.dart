import 'package:deepfake/Modules/Login/cubit/State.dart';
import 'package:deepfake/Modules/Login/cubit/cubit.dart';
import 'package:deepfake/Modules/Register/register.dart';
import 'package:deepfake/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Layout/HomeLayout.dart';
import '../../Shared/Components/constrant.dart';

class Login extends StatelessWidget {
  Login({super.key});

  TextInputType usernameType = TextInputType.emailAddress;
  TextEditingController usernameController = TextEditingController();
  TextInputType passwordType = TextInputType.visiblePassword;
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool loginSuccess =false;
  var fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..createDatabase(),
      child: BlocConsumer<LoginCubit,LoginState>(
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.getLoginCubit(context);
          return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Deep Fake Detection'),
          ),

          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: fromKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextField(
                          keyboardType: usernameType,
                          controller: usernameController,
                          label: 'Username',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                          prefixIcon: Icons.email,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextField(
                            keyboardType: passwordType,
                            controller: passwordController,
                            obscureText: cubit.isPassword,
                            label: 'Password',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Field can\'t be empty!';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.isPassword ? Icons.visibility : Icons.visibility_off,
                            visibility: (){
                              cubit.visibility();
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultButton(
                          function: (){
                            if(fromKey.currentState!.validate()) {
                              loginSuccess = false;
                              print(users);
                              for(int i=0;i<users.length;i++){
                                if (usernameController.text.toString() == users[i]['username'].toString() &&
                                    passwordController.text.toString() == users[i]['password'].toString() ) {
                                  loginSuccess = true;
                                  break;
                                }
                              }
                              if(loginSuccess){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const HomeLayout(),));
                              }
                            }
                          },
                          label: 'login',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                          }, child: const Text('Create Account!',style: TextStyle(color: Colors.blue),),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        },
        listener: (context, state) {

        },
      ),
    );
  }
}
