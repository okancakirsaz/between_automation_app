import 'package:flutter/material.dart';

class RadiusConsts {
  static final RadiusConsts instance = RadiusConsts();
  final BorderRadiusGeometry circularAll10 =
      const BorderRadius.all(Radius.circular(10));
  final BorderRadiusGeometry circularAll5 =
      const BorderRadius.all(Radius.circular(5));
  final BorderRadiusGeometry circularAll100 =
      const BorderRadius.all(Radius.circular(100));
  final BorderRadiusGeometry circularAll50 =
      const BorderRadius.all(Radius.circular(50));
  final BorderRadiusGeometry circularLeft100 = const BorderRadius.only(
      topLeft: Radius.circular(100), bottomLeft: Radius.circular(100));
  final BorderRadiusGeometry circularRight100 = const BorderRadius.only(
      topRight: Radius.circular(100), bottomRight: Radius.circular(100));
  final BorderRadiusGeometry circularTop10 = const BorderRadius.only(
      topRight: Radius.circular(10), topLeft: Radius.circular(10));
}
