import 'package:flutter/material.dart';

class CustomTheme {

  CustomTheme({
    this.lightShadowColor,
    this.darkShadowColor,
    this.lightShadowBlur,
    this.weightShadowBlur,
    this.lightShadowOffset,
    this.weightShadowOffset,
  });


  Color lightShadowColor;
  Color darkShadowColor;

  double lightShadowBlur;
  double weightShadowBlur;

  Offset lightShadowOffset;
  Offset weightShadowOffset;


  factory CustomTheme.light() =>
      CustomTheme(

      );


  factory CustomTheme.dark() =>
      CustomTheme(

      );

}
