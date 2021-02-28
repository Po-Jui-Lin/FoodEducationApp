import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/components/body.dart';

class DetailAlternative extends StatelessWidget {
  final FoodProduct altproduct;
  DetailAlternative({Key key,@required this.altproduct}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(altproduct.name),
      body: Body(),

      //bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(
        '$title',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}