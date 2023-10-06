import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/component/resuable_text_form_field.dart';
import 'package:project_todo/firebase_utils/firebase_utils.dart';
import 'package:provider/provider.dart';

import '../../dialog_utils.dart';
import '../../home/home_screen.dart';
import '../../mytheme.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/auth_provider.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeNam = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController =
      TextEditingController(text: 'Nancy@gmail.com');

  TextEditingController passwordController =
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
                        return 'Email isnot valid';
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Login();
                      },
                      child: Text(AppLocalizations.of(context)!.login,
                          style: Theme.of(context).textTheme.titleLarge),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primaryColor,
                          padding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Text(
                        AppLocalizations.of(context)!.noaccount,
                        style: provider.appTheme == ThemeMode.light
                            ? Theme.of(context).textTheme.titleSmall
                            : Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.routeNam);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signup,
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Login() async {
    if (formKey.currentState!.validate() == true) {
      // Login
      try {
        // todo: show loading
        DialogUtils.showLoading(context, 'Loading...');
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(user);
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context, 'Login successfully.',
            posActionName: 'Ok', title: 'Success', posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeNam);
        });
        print('Login successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context, 'No user found for that email.',
              posActionName: 'Ok', title: 'Error');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
              context, 'Wrong password provided for that user.',
              posActionName: 'Ok', title: 'Error');
          print('Wrong password provided for that user.');
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
