import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';

class Dots extends StatelessWidget {
  final int total;
  final int index;
  final double size;
  final Color activeColor;
  final Color defaultColor;

  Dots({
    this.total = 3,
    this.index = 0,
    this.size = 10.0,
    this.activeColor,
    this.defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (data) {
          return Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(right: data != total - 1 ? 4.0 : 0.0),
            decoration: BoxDecoration(
              color: index >= data
                  ? activeColor ?? AppColors.black
                  : defaultColor ?? AppColors.black.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
          );
        }),
      ),
    );
  }
}

class DotsPin extends StatelessWidget {
  final int total;
  final int index;
  final double size;
  final Color color;

  DotsPin({
    this.total = 3,
    this.index = 0,
    this.size = 10.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (data) {
          return Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(right: data != total - 1 ? 8.0 : 0.0),
            decoration: BoxDecoration(
              color: index > data
                  ? color ?? AppColors.white
                  : AppColors.white.withOpacity(.3),
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
          );
        }),
      ),
    );
  }
}


class SliderDots extends StatelessWidget {
  final int total;
  final int index;
  final double size;

  SliderDots({
    this.total = 3,
    this.index = 0,
    this.size = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(total, (data) {
          return Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(right: 4.0),
            decoration: BoxDecoration(
              color: index != data ? Colors.white : AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                  color: AppColors.black, width: 1, style: BorderStyle.solid),
            ),
          );
        }),
      ),
    );
  }
}