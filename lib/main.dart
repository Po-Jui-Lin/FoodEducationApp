
import 'package:flutter/material.dart';

import 'package:fyp_firebase_login/Verification_page_phone.dart';
import 'package:fyp_firebase_login/forgotPW.dart';

import 'SignUpPage sign_up_page.dart';
import 'Verification_page_email.dart';
import 'Verification_page_succeed.dart';
import 'auth_service.dart';
import 'foodeducation_Flow.dart';
import 'login_page.dart';
import 'new_userprofile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.initDynamicLinks();
    _authService.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FYP login',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  // Show Login Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: LoginPage(
                            loginWithCredentials:
                                _authService.loginWithCredentials,
                            shouldShowSignUp: _authService.showSignUp,
                            showForgotPW: _authService.showForgotPW,
                            showNewUserProfile: _authService.showNewUserProfile
                            )),

                  // Show Sign Up Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                        child: SignUpPage(
                          didProvideEmail:
                                _authService.signUpWithCredentials,
                            shouldShowLogin: _authService.showLogin,
                            )),

                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verificationEmail)
                    MaterialPage(
                        child: VerificationPageEmail(
                            backButton: _authService.showSignUp,
                            shouldShowLogin: _authService.showLogin
                    )),

                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verificationPhone)
                    MaterialPage(
                        child: VerificationPagePhone(
                            didProvideVerificationCode:
                                _authService.verifyCodeViaPhoneNum,
                            backButton: _authService.showSignUp,
                            )),

                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verified)
                    MaterialPage(
                        child: VerificationPageSucceed(
                          shouldShowLogin: _authService.showLogin,
                        )),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.resetPW)
                    MaterialPage(
                        child: forgotPW(backButton: _authService.showLogin)),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.newUser)
                    MaterialPage(
                        child: newUserProfilePage(logOutBtn: _authService.logOut, showFoodEducation: _authService.loginWithCredentials)),
                  
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: FoodEducationFlow(shouldLogOut: _authService.logOut, showFoodEducation: _authService.showFoodEducation)),

                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
