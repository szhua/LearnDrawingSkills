
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'index.dart';

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap2 = const SizedBox(width: 2.0);
  static const Widget hGap4 = const SizedBox(width: 4.0);
  static const Widget hGap5 = const SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap8 = const SizedBox(width: 8.0);
  static const Widget hGap10 = const SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap12 = const SizedBox(width: 12.0);
  static const Widget hGap15 = const SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = const SizedBox(width: Dimens.gap_dp16);
  static const Widget hGap32 = const SizedBox(width: Dimens.gap_dp32);
  /// 垂直间隔
  static const Widget vGap2 = const SizedBox(height: 2.0);
  static const Widget vGap4 = const SizedBox(height: 4.0);
  static const Widget vGap5 = const SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap6 = const SizedBox(height: 6.0);
  static const Widget vGap8 = const SizedBox(height: 8.0);
  static const Widget vGap10 = const SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = const SizedBox(height: 12.0);
  static const Widget vGap15 = const SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap16 = const SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap50 = const SizedBox(height: Dimens.gap_dp50);
  
//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );

  static Widget topDivider = const SizedBox(
    height: Dimens.gap_top_divider,
    child: const Divider(color: Colours.color_divider, thickness: Dimens.gap_top_divider, height: Dimens.gap_top_divider,),
  );

  static Widget lineDivider = const SizedBox(
    height: Dimens.gap_line_divider,
    child: const Divider(color: Colours.color_divider, thickness: Dimens.gap_line_divider, height: Dimens.gap_line_divider,),
  );
  
  static const Widget empty = const SizedBox();
}
