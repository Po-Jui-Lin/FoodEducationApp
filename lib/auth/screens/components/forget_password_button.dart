import 'package:flutter/material.dart';
import 'package:food_education_app/auth/screens/login/login_page_logic.dart';
import 'package:food_education_app/services/service_locator.dart';



class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final loginPageLogic = getIt<LoginPageLogic>();
          loginPageLogic.showForgetPW();
        },
        child: Text('Forgot password?'),
        style: TextButton.styleFrom(
          primary: Colors.grey[700],
        ));
  }
}
