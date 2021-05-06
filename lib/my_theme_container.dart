

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painter/res/colors.dart';
import 'package:painter/res/styles.dart';


class MyThemeWidget extends StatefulWidget{

  final Widget child ;
  final ThemeData themeData ;


  MyThemeWidget(this.themeData,this.child);

  static MyThemeContainer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyThemeContainer>();
  }

  @override
  State<StatefulWidget> createState() {
    return _MyThemeWidgetState(child,themeData);
  }
}

class _MyThemeWidgetState extends State<MyThemeWidget>{

  final Widget child ;
  final ThemeData themeData ;

  _MyThemeWidgetState(this.child, this.themeData);


  @override
  Widget build(BuildContext context) {
     return MyThemeContainer(themeData,child);
  }

}


class MyThemeContainer extends InheritedWidget{

  final ThemeData themeData ;
  final Widget child ;

  MyThemeContainer(this.themeData,this.child):super(child: child);



  static getRandomTheme({bool isDarkMode = false}){

    return ThemeData(
        errorColor: isDarkMode ? Colours.dark_red : Colours.app_main,
        brightness: isDarkMode ? Brightness.dark : Brightness.dark,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.dark_app_main,
        accentColor: isDarkMode ? Colours.dark_app_main : Colours.dark_app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: isDarkMode ? Colours.dark_bg_color : Colors.white,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        )
    );
  }

  static getTheme({bool isDarkMode: false}) {
    return ThemeData(
        errorColor: isDarkMode ? Colours.dark_red : Colours.red,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: isDarkMode ? Colours.dark_bg_color : Colours.app_main,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        )
    );
  }





  @override
  bool updateShouldNotify(covariant MyThemeContainer oldWidget) {
     return  themeData!=oldWidget.themeData;
  }

}