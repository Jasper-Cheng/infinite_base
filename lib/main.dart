import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/configs/app_config.dart';
import 'package:infinite_base/configs/route_config.dart';
import 'package:provider/provider.dart';

import 'controllers/extra/application_controller.dart';

//打包release apk
//flutter build apk --release --no-tree-shake-icons --no-sound-null-safety
//自动生成json解析代码
//flutter packages pub run build_runner build --delete-conflicting-outputs //触发一次构建,遍历源文件,选择相关的文件,然后为它们生成必须的序列化数据代码
//flutter pub run build_runner watch  //监听我们项目中的文件变化，并且会在需要的时候自动构建必要的文件
//签名
//jarsigner -verbose -keystore ./android/app/签名.jks -signedjar ./build/app/outputs/flutter-apk/已签名.apk ./build/app/outputs/flutter-apk/未签名.apk Alias
//jks文件转换成keystore文件
//keytool -importkeystore -srckeystore target.keystore -srcstoretype JKS -deststoretype PKCS12 -destkeystore target.p12
//keystore文件转换成jks文件
//keytool -v -importkeystore -srckeystore target.p12 -srcstoretype PKCS12 -destkeystore target.jks -deststoretype JKS
//1.腾讯加固后签名
//jarsigner -verbose -keystore ./android/app/签名.jks -signedjar ./build/app/outputs/flutter-apk/signed.apk ./build/app/outputs/flutter-apk/unsigned.apk Alias
//2.对齐 input 输入的apk路径 output 输出的apk路径
//zipalign -p -f -v 4 ./build/app/outputs/flutter-apk/signed.apk ./build/app/outputs/flutter-apk/aligned.apk
//3.确认对齐结果命令
//zipalign -c -v 4 ./build/app/outputs/flutter-apk/aligned.apk
//4.重新签名
//apksigner sign --ks (签名地址) --ks-key-alias (别名) --out (签名后的apk地址) (待签名apk地址)
//apksigner sign --ks ./android/app/签名.keystore --ks-key-alias zhijia  --out  ./build/app/outputs/flutter-apk/renew_signed.apk  ./build/app/outputs/flutter-apk/aligned.apk

void main() {
  //用于确保Flutter的Widgets绑定已经初始化
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    //透明状态栏
    SystemUiOverlayStyle systemUiOverlayStyle =
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ApplicationController())
        ],
        child: const MyApp(),
      )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ApplicationController().init(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData){
          return ScreenUtilInit(
              designSize: AppConfig.designWidthHeightDraft,
              minTextAdapt: true,
              splitScreenMode: true,
              child: MaterialApp.router(
                theme: Provider.of<ApplicationController>(context).getCurrentTheme(),
                // localizationsDelegates: const [
                //   S.delegate,
                //   GlobalMaterialLocalizations.delegate,
                //   GlobalWidgetsLocalizations.delegate,
                //   GlobalCupertinoLocalizations.delegate,
                // ],
                // supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                routerConfig: RouteConfig.router,
                builder: EasyLoading.init(),
              )
          );
        }else{
          return Container();
        }
      },
    );

    // return ScreenUtilInit(
    //   designSize: AppConfig.designWidthHeightDraft,
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (context,child){
    //     return FutureBuilder(
    //       future: ApplicationController().init(),
    //       builder: (context, snapshot){
    //         if(snapshot.connectionState == ConnectionState.done&&!snapshot.hasError){
    //           return MaterialApp.router(
    //             theme: Provider.of<ApplicationController>(context).getCurrentTheme(),
    //             // localizationsDelegates: const [
    //             //   S.delegate,
    //             //   GlobalMaterialLocalizations.delegate,
    //             //   GlobalWidgetsLocalizations.delegate,
    //             //   GlobalCupertinoLocalizations.delegate,
    //             // ],
    //             // supportedLocales: S.delegate.supportedLocales,
    //             debugShowCheckedModeBanner: false,
    //             routerConfig: RouteConfig.router,
    //             builder: EasyLoading.init(),
    //           );
    //         }else{
    //           return Container();
    //         }
    //       },
    //     );
    //   },
    // );
  }
}