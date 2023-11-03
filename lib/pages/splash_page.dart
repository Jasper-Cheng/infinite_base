import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/configs/assets_config.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

import '../controllers/splash_page_controller.dart';

class SplashPage extends BasePage {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends BasePageState<SplashPage> {

  final SplashPageController _controller=SplashPageController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Opacity(
        opacity : _controller.hadGuide==null?0.0:1.0,
        child: _controller.hadGuide==false?PageView(
          controller: _controller.pageController,
          scrollDirection : Axis.horizontal,
          // physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Image.asset(
                  AssetImageConfig.splash1,
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  left: 20.w,
                  bottom: 30.h,
                  right: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "欢迎使用",
                        style: TextStyle(color: Colors.white,fontSize: 30.sp,fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 24.h,
                      ),
                      Text(
                        "MorningGo",
                        style: TextStyle(color: const Color(0xFF3295FB),fontSize: 40.sp,fontWeight: FontWeight.w800),
                      ),
                      Container(
                        height: 20.h,
                      ),
                      Text(
                        "期待你每一次的打开，愿世间美好与你环环相扣",
                        style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().screenHeight/3.8,left: 30.w,right: 30.w),
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: Column(
                children: [
                  Image.asset(
                    AssetImageConfig.splash2_1,
                    fit: BoxFit.fill,
                    height: 136.h,
                  ),
                  Container(
                    height: 40.h,
                  ),
                  Text(
                    "我们为您提供\n专业的打车出行服务",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: const Color(0xFF1C1F23),fontSize: 20.sp,fontWeight: FontWeight.w900,letterSpacing: 6.h),
                  ),
                  Container(
                    height: 50.h,
                  ),
                  Image.asset(
                    AssetImageConfig.splash2_2,
                    fit: BoxFit.fill,
                    height: 5.h,
                  ),
                  Container(
                    height: 80.h,
                  ),
                  MaterialButton(
                    minWidth: ScreenUtil().screenWidth,
                    height: 36.h,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.r),
                      ),
                    ),
                    color: const Color(0xFF0077FA),
                    child: Text("下一页",style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w600),),
                    onPressed: (){
                      _controller.pageController?.nextPage(duration: const Duration(milliseconds: 800),curve: Curves.easeOut);
                    },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().screenHeight/3.8,left: 30.w,right: 30.w),
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: Column(
                children: [
                  Image.asset(
                    AssetImageConfig.splash3_1,
                    fit: BoxFit.fill,
                    height: 136.h,
                  ),
                  Container(
                    height: 40.h,
                  ),
                  Text(
                    "我们为您提供\n既叫即到的打车体验",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: const Color(0xFF1C1F23),fontSize: 20.sp,fontWeight: FontWeight.w900,letterSpacing: 6.h),
                  ),
                  Container(
                    height: 50.h,
                  ),
                  Image.asset(
                    AssetImageConfig.splash3_2,
                    fit: BoxFit.fill,
                    height: 5.h,
                  ),
                  Container(
                    height: 80.h,
                  ),
                  MaterialButton(
                    minWidth: ScreenUtil().screenWidth,
                    height: 36.h,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.r),
                      ),
                    ),
                    color: const Color(0xFF0077FA),
                    child: Text("下一页",style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w600),),
                    onPressed: (){
                      _controller.pageController?.nextPage(duration: const Duration(milliseconds: 800),curve: Curves.easeOut);
                    },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().screenHeight/3.8,left: 30.w,right: 30.w),
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: Column(
                children: [
                  Image.asset(
                    AssetImageConfig.splash4_1,
                    fit: BoxFit.fill,
                    height: 136.h,
                  ),
                  Container(
                    height: 40.h,
                  ),
                  Text(
                    "立即体验感受\n不一样的出行服务",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: const Color(0xFF1C1F23),fontSize: 20.sp,fontWeight: FontWeight.w900,letterSpacing: 6.h),
                  ),
                  Container(
                    height: 50.h,
                  ),
                  Image.asset(
                    AssetImageConfig.splash4_2,
                    fit: BoxFit.fill,
                    height: 5.h,
                  ),
                  Container(
                    height: 80.h,
                  ),
                  MaterialButton(
                    minWidth: ScreenUtil().screenWidth,
                    height: 36.h,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.r),
                      ),
                    ),
                    color: const Color(0xFF0077FA),
                    child: Text("立即体验",style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w600),),
                    onPressed: (){
                      _controller.jumpToLoginWidget();
                    },
                  )
                ],
              ),
            )
          ],
        ):Stack(
          alignment:Alignment.center,
          children: [
            Image.asset(
              AssetImageConfig.helloWorld,
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: ScreenUtil().statusBarHeight,
              right: 30.w,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(60.r)),
                  ),
                  child: Text("跳过${_controller.countDown}秒",style: TextStyle(fontSize: 12.sp),),
                ),
                onTap: (){
                  _controller.jumpToLoginWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
