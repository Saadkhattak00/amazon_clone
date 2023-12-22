import 'package:amazon_clone/common/widgets/Custom_TextFeild.dart';
import 'package:amazon_clone/common/widgets/Custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/authScreen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signIn;
  final _signInKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();
  final Auth_Services authServices = Auth_Services();
  final TextEditingController _nameTextFieldController =
      TextEditingController();
  final TextEditingController _emailTextFieldController =
      TextEditingController();
  final TextEditingController _passwordTextFieldController =
      TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _nameTextFieldController.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
  }
// Function For SignUp
  void signUpUser(){
    authServices.signUpUser(
        context: context,
        email: _emailTextFieldController.text,
        password: _passwordTextFieldController.text,
        name: _nameTextFieldController.text);
  }
// Function For SignIn
  void signInUser(){
    authServices.signInUser(
        context: context,
        email: _emailTextFieldController.text,
        password: _passwordTextFieldController.text,
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  "SignIn",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signIn)
                Form(
                  key: _signInKey,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        Custom_TextField(
                          controller: _emailTextFieldController,
                          hint: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Custom_TextField(
                          controller: _passwordTextFieldController,
                          hint: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(text: 'SignIn', onTap: () {
                          if (_signInKey.currentState!.validate()){
                            signInUser();
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  "Create account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signUp)
                Form(
                  key: _signUpKey,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        Custom_TextField(
                          controller: _nameTextFieldController,
                          hint: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Custom_TextField(
                          controller: _emailTextFieldController,
                          hint: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Custom_TextField(
                          controller: _passwordTextFieldController,
                          hint: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(text: 'Create', onTap: () {
                          if (_signUpKey.currentState!.validate()){
                            signUpUser();
                          }
                        }),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
