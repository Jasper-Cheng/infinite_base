import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/configs/assets_config.dart';

class NormalToolbarView extends StatelessWidget{
  final Color backgroundColor;
  final bool resizeToAvoidBottomPadding;
  final Widget? bottomNavigationBar;
  final SystemUiOverlayStyle systemUiOverlayStyle;
  final double? toolbarHeight;
  final bool showLeadingView;
  final Widget? leadingLeftWidget;
  final Widget? leadingRightWidget;
  final Widget? leadingCenterWidget;
  final Widget body;
  final VoidCallback? onBackClick;
  final bool showLeadingLeftWidget;
  final bool showLeadingCenterWidget;
  final bool showLeadingRightWidget;

  const NormalToolbarView({Key? key,
    this.backgroundColor=Colors.transparent,
    this.resizeToAvoidBottomPadding=true,
    this.bottomNavigationBar,
    this.systemUiOverlayStyle=SystemUiOverlayStyle.dark,
    this.toolbarHeight,
    this.showLeadingView=true,
    this.leadingRightWidget,
    this.leadingLeftWidget,
    this.leadingCenterWidget,
    required this.body,
    this.onBackClick,
    this.showLeadingLeftWidget = true,
    this.showLeadingCenterWidget = true,
    this.showLeadingRightWidget = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
          bottomNavigationBar: bottomNavigationBar,
          body: Container(
            margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
            child: Column(
              children: [
                showLeadingView?_buildLeadView(context):Container(),
                Expanded(
                  child: body
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _buildLeadView(BuildContext context){
    double theToolbarHeight = toolbarHeight ?? 36.h;
    return SizedBox(
      height: theToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showLeadingLeftWidget?leadingLeftWidget??GestureDetector(
            onTap: onBackClick??(){
              context.pop();
            },
            child: Container(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                AssetImageConfig.arrow_left_line,
                width: 20.w,
                fit: BoxFit.fill,
              ),
            ),
          ):Container(),
          showLeadingCenterWidget?Expanded(
            child: leadingCenterWidget??Container(),
          ):Container(),
          showLeadingRightWidget?leadingRightWidget??Container():Container()
        ],
      ),
    );
  }

}