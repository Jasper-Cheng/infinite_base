import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
      padding: EdgeInsets.only(top: 30.h,left: 20.w,right: 20.w,bottom: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "验证码已发送至 ",
                  style: TextStyle(
                      color: const Color(0xCC1C1F23),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp
                  ),
                ),
                Text(
                  "16616638630",
                  style: TextStyle(
                      color: const Color(0xCC1C1F23),
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp
                  ),
                ),
              ],
            ),
            Container(
              height: 24.h,
            ),
            PinCodeTextField(
                textStyle: const TextStyle(color: Colors.black),
                showCursor: false,
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                animationType: AnimationType.none,//动画的类型
                textInputAction: TextInputAction.done, //右下角的按键功能，是完成，可以选择其他的
                appContext: context,
                length: 4,
                onChanged: _controller.updateVerificationCode,
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
            Container(
              height: 20.h,
            ),
            GestureDetector(
              onTap: _controller.startTimerCount,
              child: Text(
                _controller.countTip,
                style: TextStyle(
                    color: const Color(0xCC1C1F23),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp
                ),
              ),
            ),
            Container(
              height: 30.h,
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
                    onPressed: _controller.verificationCode.length>=4?_controller.doVerificationStep:null,
                    child: Text("验证",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                  ),
                )
              ],
            ),
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