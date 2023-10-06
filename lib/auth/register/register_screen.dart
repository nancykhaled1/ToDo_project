import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/component/resuable_text_form_field.dart';
import 'package:project_todo/dialog_utils.dart';
import 'package:project_todo/firebase_utils/firebase_utils.dart';
import 'package:project_todo/home/home_screen.dart';
import 'package:project_todo/model/user_data.dart';
import 'package:project_todo/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../mytheme.dart';
import '../../providers/app_config_provider.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeNam = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: 'Nancy');

  TextEditingController emailController =
      TextEditingController(text: 'Nancy@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmationPasswordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/background.png'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  TextFormWidget(
                    text: AppLocalizations.of(context)!.username,
                    style: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor,
                    ),
                    controller: nameController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please enter userName';
                      }
                      return null;
                    },
                  ),
                  TextFormWidget(
                    text: AppLocalizations.of(context)!.email,
                    style: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor,
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please enter Email';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  TextFormWidget(
                    text: AppLocalizations.of(context)!.password,
                    style: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor,
                    ),
                    isobscure: true,
                    keyboardType: TextInputType.number,
                    controller: passwordController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please enter Password';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 char';
                      }
                      return null;
                    },
                  ),
                  TextFormWidget(
                    text: AppLocalizations.of(context)!.confirmPass,
                    style: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackColor
                          : MyTheme.whiteColor,
                    ),
                    isobscure: true,
                    keyboardType: TextInputType.number,
                    controller: confirmationPasswordController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please enter confirmation password';
                      }
                      if (text != passwordController.text) {
                        return 'password doesnot match ';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Register();
                      },
                      child: Text(AppLocalizations.of(context)!.register,
                          style: Theme.of(context).textTheme.titleLarge),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primaryColor,
                          padding: EdgeInsets.all(10)),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeNam);
                      },
                      child: Text(
                          AppLocalizations.of(context)!.alreadyhaveanaccount))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Register() async {
    if (formKey.currentState!.validate() == true) {
      // register
      try {
        // todo: show loading
        DialogUtils.showLoading(context, 'Loading...');
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFirestore(myUser);
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(myUser);
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context, 'Register successfully.',
            posActionName: 'Ok', title: 'Success', posAction: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeNam);
        });
        print('Register successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context, 'The password provided is too weak.',
              posActionName: 'Ok', title: 'Error');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context, 'The account already exists for that email.',
              posActionName: 'Ok');
          print('The account already exists for that email.');
        }
      } catch (e) {
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context, '${e.toString()}',
            posActionName: 'Ok');
        print(e);
      }
    }
  }
}
