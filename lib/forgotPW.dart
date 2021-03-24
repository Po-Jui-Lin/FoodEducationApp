
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotPW extends StatefulWidget {

  final VoidCallback backButton;

  forgotPW({Key key, this.backButton})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _forgotPWState();
}

class _forgotPWState extends State<forgotPW> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _formKeyForgotPW = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: new IconButton(
          color: Colors.grey[700],
          icon: new Icon(Icons.arrow_back),
          splashRadius: 24,
          onPressed: widget.backButton,
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _forgotPWForm(),
      ),
    );
  }

  Widget _forgotPWForm() {
    return Form(
        key: _formKeyForgotPW,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title: Forgot Password"),
            TextFormField(
                controller: _emailController,
                decoration:
                InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                }),

            // Verify Button
            FlatButton(
                onPressed: () {
                  if (_formKeyForgotPW.currentState.validate()) {
                    _resetPW();
                    _emailController.clear();
                  }
                },
                child: Text("Submit"),
                color: Theme
                    .of(context)
                    .accentColor),
          ],
        ));
  }

  void _resetPW() async {
    final email = _emailController.text.trim();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    var actionCodeSettings = ActionCodeSettings(
        url: 'https://fyptest1.page.link/resetpw/',
        dynamicLinkDomain: "fyptest1.page.link",
        androidPackageName: "com.example.fyp_firebase_login",
        androidInstallApp: true,
        handleCodeInApp: true,
        iOSBundleId: "com.example.fyp_firebase_login");

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email, actionCodeSettings: actionCodeSettings);
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Reset password'),
              content: Text("Please check your inbox and follow the instructions."),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'user-not-found') {
        showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Email Issue'),
                content: Text("This email is not registered."),
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
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text("Error code: ${authError.code}"),
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
  }
}