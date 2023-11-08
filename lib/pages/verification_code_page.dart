import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../configs/assets_config.dart';
import '../controllers/verification_code_page_controller.dart';

class VerificationPage extends BasePage{
  const VerificationPage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<StatefulWidget> createState() => VerificationPageState();

}
class VerificationPageState extends BasePageState{
  final VerificationCodePageController _controller=VerificationCodePageController();
  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
      leadingLeftWidget: _buildLeftView(),
      body: _buildBodyView(),
    );
  }

  Widget _buildLeftView(){
    return Container(
      padding: EdgeInsets.only(left:6.w,bottom: 2.h),
      child: GestureDetector(
        child: Text(
          "验证码",
          style: TextStyle(
            color: const Color(0xFF1C1F23),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: (){
          context.pop();
        },
      ),
    );
  }

  Widget _buildBodyView(){
    return Container(
      padding: EdgeInsets.only(top: 30.h,left: 10.w,right: 10.w,bottom: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: PinCodeTextField(
                textStyle: const TextStyle(color: Colors.black),
                  onCompleted: (value) {
                    print('oncompletd $value');
                  },
                  showCursor: false,
                  blinkDuration: Duration.zero,
                  animationDuration: Duration.zero,
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  animationCurve: Curves.bounceInOut, //动画的效果
                  animationType: AnimationType.fade,//动画的类型
                  textInputAction: TextInputAction.done, //右下角的按键功能，是完成，可以选择其他的
                  appContext: context,
                  length: 4,
                  onChanged: (value) => print("onchange $value"),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box, //输入框的形状
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    selectedColor: const Color(0xFF3295FB),
                    selectedFillColor: const Color(0xFFEAF5FF),
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    inactiveFillColor: const Color(0x0D2E3238),
                    activeFillColor: const Color(0x0D2E3238),
                    fieldWidth: 66.w,
                    // 其他可以设置可以自己参考，比如有输入文字的时候输入框是什么颜色，不能输入的时候是什么颜色等
                  )),
            ),
            // PinCodeTextField(
            //   appContext: context,
            //   length: 4,
            //   // backgroundColor: const Color(0x0D2E3238),
            //   keyboardType: TextInputType.number,
            //     pinTheme: PinTheme(
            //       selectedColor: const Color(0xFF3295FB),
            //       shape: PinCodeFieldShape.box, //输入框的形状
            //       borderRadius: const BorderRadius.all(Radius.circular(10)),
            //     )
            // ),
            Container(
              height: 24.h,
            ),
            Text(
              " 请选择使用哪种方式重置您的密码",
              style: TextStyle(
                color: const Color(0xCC1C1F23),
                fontWeight: FontWeight.w500,
                fontSize: 13.sp
              ),
            ),
            Container(
              height: 30.h,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    _controller.updateSelectWay(1);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: _controller.selectWay==1?Border.all(color: const Color(0xFF0077FA),width: 1.2.w):Border.all(color: const Color(0xFF1C1F23),width: 0.1.w)
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AssetImageConfig.forgot_password_select1,
                          width: 50.w,
                          fit: BoxFit.fill,
                        ),
                        Container(width: 12.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("电话",style: TextStyle(color: const Color(0x991C1F23),fontSize: 12.sp),),
                            Container(height: 10.h,),
                            Text("13060927658",style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.w600),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 18.h,
                ),
                GestureDetector(
                  onTap: (){
                    _controller.updateSelectWay(2);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: _controller.selectWay==2?Border.all(color: const Color(0xFF0077FA),width: 1.2.w):Border.all(color: const Color(0xFF1C1F23),width: 0.1.w)
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AssetImageConfig.forgot_password_select2,
                          width: 50.w,
                          fit: BoxFit.fill,
                        ),
                        Container(width: 12.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("邮箱",style: TextStyle(color: const Color(0x991C1F23),fontSize: 12.sp),),
                            Container(height: 10.h,),
                            Text("junyi@smarticon.com",style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.w600),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 36.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 38.h,
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.r),
                          ),
                        ),
                        disabledElevation: 6,
                        elevation: 6,
                        color: const Color(0xFF0077FA),
                        disabledColor: const Color(0xFF98CDFD),
                        onPressed: _controller.selectWay!=0?_controller.doWayNextStep:null,
                        child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  @override
  BaseController initController() {
    return _controller;
  }

}