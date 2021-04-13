import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  final String searchname;

  DetailResult({Key key, @required this.searchname}) : super(key: key);

  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');

  String foodProductCategory;

  @override
  Widget build(BuildContext context) {
    //todo:function 1 and store in tempfood
    // search name => barcode (key)
    FoodProduct tempfood;
    foodProductCollection.doc("searchname").get().then((snapshot) {
      try {
        foodProductCategory = snapshot.get("category");
        tempfood = FoodProduct(
            name: snapshot.get("name"),
            category: foodProductCategory,
            volumeOrweight: snapshot.get("volumeOrweight"),
            energy: snapshot.get("energy"),
            protein: snapshot.get("protein"),
            totalFat: snapshot.get("totalFat"),
            saturatetedFat: snapshot.get("saturatetedFat"),
            transFat: snapshot.get("transFat"),
            carbohydrates: snapshot.get("totalCarbonhydrates"),
            dietarytFibre: snapshot.get("dietarytFibre"),
            sugars: snapshot.get("sugars"),
            sodium: snapshot.get("sodium"),
            image: snapshot.get("image"),
            grade: snapshot.get("grade"),
            ingredients: snapshot.data()["ingredients"],
            star: snapshot.get("star"));
      } on StateError catch (e) {
        print("Error: getproduct");
      }
    });

    tempfood.calculateTotalNutrient();
    tempfood.printproduct();

    //todo: function 5 get current user height weight sex->calculate recDaily
    _getUserInfo();

    //todo: function 4 get maxSametype,minSametype by category
    List<DailyIntake> tempDaily = _findMaxMin("productCategory");


    //todo:function 3 and store in alt2product
    List<AlternativeProduct> alt2product;

    var getalt2product = foodProductCollection.where('category', isEqualTo: foodProductCategory).limit(2);
    getalt2product.get().then((value) {
      value.docs.map((DocumentSnapshot document) {
        try {
          alt2product.add(
            AlternativeProduct(name: document.data()["name"], image: document.data()["image"]));

        } on StateError catch (e) {
          print("Error: getalt2product");
        }
      });
    });

    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body: Body(
        product: tempfood,
        daily: tempDaily,
        alt2product: alt2product,
      ),

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

  void _barcodeSearch(String barcodeID) {
    // 2 get foodproduct, you must pass barcode(String) to me
    FoodProduct tempfoodByBarcode;
    var barcodeSnapshots =
        foodProductCollection.where("barcode", isEqualTo: barcodeID);
    // barcodeSnapshots.get().docs.map((DocumentSnapshot document) {});
    barcodeSnapshots.get().then((value) {
      value.docs.map((DocumentSnapshot document) {
        try {
          tempfoodByBarcode = FoodProduct(
              name: document.data()["name"],
              category: document.data()["category"],
              volumeOrweight: document.data()["volumeOrweight"],
              energy: document.data()["energy"],
              protein: document.data()["protein"],
              totalFat: document.data()["totalFat"],
              saturatetedFat: document.data()["saturatetedFat"],
              transFat: document.data()["transFat"],
              carbohydrates: document.data()["totalCarbonhydrates"],
              dietarytFibre: document.data()["dietarytFibre"],
              sugars: document.data()["sugars"],
              sodium: document.data()["sodium"],
              image: document.data()["image"],
              grade: document.data()["grade"],
              ingredients: document.data()["ingredients"],
              star: document.data()["star"]);
        } on StateError catch (e) {
          print("Error: getproductByBarcode");
        }
      });
    });
  }

  List<DailyIntake> _findMaxMin(String productCategory) {
    // 3
    var categoryResult =
        foodProductCollection.where('category', isEqualTo: productCategory);

    List<DailyIntake> tempDaily;

    // method 1
    List<String> labelTag = [
      "energy",
      "protein",
      "totalfat",
      "saturatedFat",
      "transFat",
      "carbohydrates",
      "sugars",
      "sodium"
    ];

    for (String tempLabel in labelTag) {
      Query maxQ = categoryResult
          .orderBy(tempLabel, descending: true)
          .limit(1); //find max
      Query minQ = categoryResult
          .orderBy(tempLabel, descending: false)
          .limit(1); //find min
      double max, min;
      maxQ.get().then((value) => max = value.docs.first.data()[tempLabel]);
      minQ.get().then((value) => min = value.docs.first.data()[tempLabel]);
      tempDaily.add(DailyIntake(
          nutrient: tempLabel,
          maxSametype: max,
          minSametype: min,
          recDaily: 1000));
    }
    return tempDaily;
  }

  void _getUserInfo() async {
    // 5
    final User _user = FirebaseAuth.instance.currentUser;
    DocumentReference userInfo =
        FirebaseFirestore.instance.collection('userprofile').doc(_user.uid);

    double height, weight;
    String sex;
    try {
      await userInfo.get().then((snapshot) {
        height = snapshot.get('height');
        weight = snapshot.get('weight');
        sex = snapshot.get('sex');
      });
    } on StateError catch (e) {
      print("Error: UserInfo");
    }
  }
}
