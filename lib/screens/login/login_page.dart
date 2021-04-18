import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/screens/login/login_page_logic.dart';
import 'package:food_education_app/services/service_locator.dart';

import '../../auth_service.dart';
import 'components/forget_password_button.dart';
import 'components/login_button.dart';
import 'components/login_form.dart';
import 'components/or_divider.dart';
import 'components/goto_sign_up_button.dart';
import 'components/social_media_row.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;

  LoginPage({
    Key key,
    @required this.authService,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

//  todo: Login page UI
// todo: Support email & FB & google now. If you want to support phone number, you can design related UI to login page and sign up page

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final loginLogic = getIt<LoginPageLogic>();
    loginLogic.setup(widget.authService, _showErrorDialog, _setLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _loading ? Center(child: CircularProgressIndicator()) : LoginForm(),
    );
  }

  void _setLoading(bool loading){
    setState(() {
      _loading = loading;
    });
  }

  // todo: login Page dialog
  void _showErrorDialog(String title, String content) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({
    Key key,
    bool loading,
  })  : super(key: key);


  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      // Login Form
      _loginForm(),
      // Sign Up Button
      GoToSignUpButton(),
    ]));
  }

  Widget _loginForm() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmailFormField(
            emailController: _emailController,
          ),
          PasswordFormField(passwordController: _passwordController),
          LoginButton(
              formKeyLogin: _formKeyLogin,
              emailController: _emailController,
              passwordController: _passwordController),
          ForgetPasswordButton(),
          OrDivider(),
          SocialMediaRow(),
        ],
      ),
    );
  }
}
