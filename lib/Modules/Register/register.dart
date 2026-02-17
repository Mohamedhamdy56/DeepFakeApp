import 'package:deepfake/Modules/Login/cubit/State.dart';
import 'package:deepfake/Modules/Login/login.dart';
import 'package:deepfake/Modules/Register/cubit/cubit.dart';
import 'package:deepfake/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Login/cubit/cubit.dart';

class Register extends StatelessWidget {
  Register({super.key});

  TextInputType usernameType = TextInputType.emailAddress;
  TextEditingController usernameController = TextEditingController();
  TextInputType passwordType = TextInputType.visiblePassword;
  TextEditingController passwordController = TextEditingController();
  TextInputType confirmPasswordType = TextInputType.visiblePassword;
  TextEditingController confirmPasswordController = TextEditingController();
  TextInputType birthdayType = TextInputType.datetime;
  TextEditingController birthdayController = TextEditingController();

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
                child: Form(
                  key: fromKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'REGISTER',
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
                            obscureText: cubit.isPasswordConfirm,
                            label: 'Password',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Field can\'t be empty!';
                              }else if(value!= confirmPasswordController.text){
                                return 'password not equal';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.isPasswordConfirm ? Icons.visibility : Icons.visibility_off,
                            visibility: (){
                              cubit.visibilityConfirm();
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextField(
                            keyboardType: confirmPasswordType,
                            controller: confirmPasswordController,
                            obscureText: cubit.isPasswordConfirm,
                            label: 'Confirm Password',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Field can\'t be empty!';
                              }else if(value!= passwordController.text){
                                return 'password not equal';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.isPasswordConfirm ? Icons.visibility : Icons.visibility_off,
                            visibility: (){
                              cubit.visibilityConfirm();
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextField(
                          keyboardType: birthdayType,
                          controller: birthdayController,
                          label: 'Birthdate',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                          readOnly: true,
                          prefixIcon: Icons.date_range_rounded,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, //context of current state
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              birthdayController.text = formattedDate;
                            }else{
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultButton(
                          function: (){
                            if(fromKey.currentState!.validate()){
                              cubit.insertToDatabase(usernameController.text, passwordController.text, birthdayController.text);
                              Navigator.pop(context, MaterialPageRoute(builder: (context) => Login(),));
                            }
                          },
                          label: 'register',
                        ),
                      ),
                    ],
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
