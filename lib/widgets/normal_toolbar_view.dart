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
  final Widget? leadingCenterWidget;
  final Widget? leadingRightWidget;
  final Widget body;
  final VoidCallback? onBackClick;
  final bool showLeadingBack;

  const NormalToolbarView({Key? key,
    this.backgroundColor=Colors.transparent,
    this.resizeToAvoidBottomPadding=true,
    this.bottomNavigationBar,
    this.systemUiOverlayStyle=SystemUiOverlayStyle.dark,
    this.toolbarHeight,
    this.showLeadingView=true,
    this.leadingRightWidget,
    this.leadingCenterWidget,
    this.leadingLeftWidget,
    required this.body,
    this.onBackClick,
    this.showLeadingBack = true,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showLeadingBack?GestureDetector(
            onTap: onBackClick??(){
              context.pop();
            },
            child: Container(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                AssetImageConfig.arrow_left_line,
                width: 18.w,
                fit: BoxFit.fill,
              ),
            ),
          ):Container(),
          Expanded(
            child: leadingLeftWidget??Container(),
          ),
          Expanded(
            child: leadingCenterWidget??Container(),
          ),
          Expanded(
            child: leadingRightWidget??Container(),
          ),
        ],
      ),
    );
  }

}