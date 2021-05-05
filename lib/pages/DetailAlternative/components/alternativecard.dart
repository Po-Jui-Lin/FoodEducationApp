import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
//import 'package:flutter/cupertino.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_education_app/pages/DetailScore/detail_score_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
class AlternativeCard extends StatelessWidget {
  const AlternativeCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  final AlternativeProduct product;
  final Function press;
  String getGradeImage(String grade){
    String gradeimage;
    if (grade == "A") {
      gradeimage = "assets/icons/A-1.svg";
    }
    if (grade == "B") {
      gradeimage = "assets/icons/B-2.svg";
    }
    if (grade == "C") {
      gradeimage = "assets/icons/C-3.svg";
    }
    if (grade == "D") {
      gradeimage = "assets/icons/D-4.svg";
    }
    return gradeimage;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //width: size.width * 0.3,
      height: size.height * 0.14,
      //color: Colors.grey,
      child: Card(
        elevation: 0,
        //color: Colors.blue,
        child: InkWell(
            onTap: () {},//todo: when ontap, build Detailresult(searchname:product.name)
            child: Row(
              children: [
                Container(
                    //padding: EdgeInsets.all(kDefaultPadding * 0.1),
                    height: size.height * 0.14,
                    width: size.width * 0.38,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          height: size.height * 0.13,
                          width: size.width * 0.35,
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(14),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            imageBuilder: (context, imageProvider) => Container(
                              //color: Colors.green,
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                                // border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(
                                  image: NetworkImage(product.image),
                                  //imageProvider
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor))),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: size.height * 0.05,
                              width: size.height * 0.05,// ensure the circle is in a squared box
                              color: Colors.transparent,
                              child: SvgPicture.asset(getGradeImage(product.grade)),
                              ),
                            //
                ),

                      ],
                    )),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Expanded(
                  //the width is expanded
                  child: Container(
                    height: size.height * 0.14,
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.04,
                          //color: Colors.lightGreenAccent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              product.name,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                        Container(
                            height: size.height * 0.04,
                            //color: Colors.yellow,
                            child: Row(
                              children: [
                                Text(
                                  product.star.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                RatingBar(
                                  initialRating: product.star,
                                  ratingWidget: RatingWidget(
                                      full: Icon(
                                        Icons.star,
                                        color: kPrimaryColor,
                                      ),
                                      half: Icon(
                                        Icons.star_half,
                                        color: kPrimaryColor,
                                      ),
                                      empty: Icon(
                                        Icons.star_border,
                                        color: kPrimaryColor,
                                      )),
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  allowHalfRating: true,
                                  itemSize: size.width * 0.04,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              ],
                            )),
                        Container(
                            //color: Colors.lightGreenAccent,
                            height: size.height * 0.04,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.calories.toStringAsFixed(0) + " Calories",
                                style: TextStyle(
                                  fontSize: size.width *
                                      0.035, //slightly smaller than product name and star
                                  //fontWeight: FontWeight.bold, no bold here
                                ),
                                softWrap: false,
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

}
