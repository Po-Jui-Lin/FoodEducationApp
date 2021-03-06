import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/triplebox.dart';
import 'header.dart';
import 'nutritionbox.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/dailyintake.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.product,
    @required this.daily,
    @required this.alt2product,
  }) : super(key: key);
  final FoodProduct product;
  final List<DailyIntake> daily;
  final List <AlternativeProduct> alt2product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScoreArray scoreArray= this.product.calculateGrade();
    //this.product.printproduct();
    // print(scoreArray.cautions);
    // print(scoreArray.grade);

    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size,product:product,scoreArray:scoreArray),
          SizedBox(height: size.height * 0.02),
          NutritionBox(
            size: size,
            product: product,
            daily:daily,
          ),
          SizedBox(height: size.height * 0.02),
          Triplebox(
            size: size,
            product: product,
            scoreArray: scoreArray,
            alt2product: alt2product,
          ),
        ],
      ),
    );
  }
}
