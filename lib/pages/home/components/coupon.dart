import 'package:flutter/material.dart';
import '../../../constants.dart';

class Coupon extends StatelessWidget {
  const Coupon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          CouponCard(
            image: "assets/images/coupon1.jpg",
            press: () {},
          ),
          CouponCard(
            image: "assets/images/coupon2.jpg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  const CouponCard({
    Key key,
    this.image,
    this.press,
  }) : super(key: key);
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.6,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
