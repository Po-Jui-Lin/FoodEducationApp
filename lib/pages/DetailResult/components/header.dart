import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailScore/detail_score_screen.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
    @required this.product,
    @required this.scoreArray,
  }) : super(key: key);

  final Size size;
  final FoodProduct product;
  final ScoreArray scoreArray;

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
      // explanation: margin between this container and "Recommended section title

      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              // Bottom padding not affecting the UI
              bottom: 36 + kDefaultPadding,
            ),
            // explanation: minus 27 to lift this container away up from the wrapping container
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Colors.red,
              // location: the bottom corner of the teal header block
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
          ),
          Positioned(
              top: 10,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 10),
                height:
                    size.height * 0.18, //use dynamic value(change by figo 25/2)
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3.7),
                      blurRadius: 14,
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailedScore(
                                product: product,
                                scoreArray: scoreArray,
                              ))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.2,
                          width: size.width * 0.4,
                          //color: Colors.green,
                          decoration: new BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                  image: AssetImage(product.image),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            //color: Colors.red,
                            padding: const EdgeInsets.only(left:8.0,right:8.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFFF6FAF9),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 8.0,),
                                Container(
                                  height: size.height*0.03,
                                  child: FittedBox(
                                    child: Text(
                                      "Is this product good for you?",
                                      style: TextStyle(
                                        fontSize: size.height * 0.02,
                                        //fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: double.infinity,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: size.height * 0.03,
                                                      child: FittedBox(
                                                        child: Text(
                                                          scoreArray.checks.length
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: kPrimaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width:2),
                                                    Icon(
                                                      Icons.check,
                                                      color: kPrimaryColor,
                                                      size: size.height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height:4),
                                                FittedBox(
                                                    child: Text(
                                                  "Checks",
                                                  style: TextStyle(
                                                    color: kPrimaryColor,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: double.infinity,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(14),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: size.height * 0.03,
                                                      child: FittedBox(
                                                        child: Text(
                                                          scoreArray.cautions.length
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width:2),
                                                    Icon(
                                                      Icons.dangerous,
                                                      color: Colors.orange,
                                                      size: size.height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height:4),
                                                FittedBox(
                                                    child: Text(
                                                      "Cautions",
                                                      style: TextStyle(
                                                        color: Colors.orange,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
