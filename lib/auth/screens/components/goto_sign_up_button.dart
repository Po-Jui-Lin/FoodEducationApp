import 'package:flutter/material.dart';
import 'package:food_education_app/auth/screens/login/login_page_logic.dart';
import 'package:food_education_app/services/service_locator.dart';



class GoToSignUpButton extends StatelessWidget {
  const GoToSignUpButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logicClass = getIt<LoginPageLogic>();
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: logicClass.shouldShowSignUp,
        child: Text('Don\'t have an account? Sign up.'),
        style: TextButton.styleFrom(
          primary: Colors.grey[800],
        ),
      ),
    );
  }
}
