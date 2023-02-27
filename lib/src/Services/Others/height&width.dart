import 'package:flutter/material.dart';

heightScr(context, int percent) {
  String txtPer = '0.$percent';
  double checkDouble = (percent == 100) ? 1.0 : double.parse(txtPer);
  return MediaQuery.of(context).size.height * checkDouble;
}

widthScr(context, int percent) {
  String txtPer = '0.$percent';
  double checkDouble = (percent == 100) ? 1.0 : double.parse(txtPer);
  return MediaQuery.of(context).size.width * checkDouble;
}
