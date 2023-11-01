import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:infinite_base/utils/log_util.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationUtil {
  // 使用单例模式进行初始化
  static final NotificationUtil _instance = NotificationUtil._internal();
  factory NotificationUtil() => _instance;
  NotificationUtil._internal();

  // FlutterLocalNotificationsPlugin是一个用于处理本地通知的插件，它提供了在Flutter应用程序中发送和接收本地通知的功能。
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  String channelId="1";
  String channelName="Jasper";
  String channelDescription="test notification description";
  String ticker="ticker";

  // 初始化函数
  Future<void> initialize() async {
    // AndroidInitializationSettings是一个用于设置Android上的本地通知初始化的类
    // 使用了app_icon作为参数，这意味着在Android上，应用程序的图标将被用作本地通知的图标。
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    // 15.1是DarwinInitializationSettings，旧版本好像是IOSInitializationSettings（有些例子中就是这个）
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    // 初始化
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse){
        LogUtil.d("onDidReceiveNotificationResponse notificationResponse.payload  ${notificationResponse.payload}");
      },
      // onDidReceiveBackgroundNotificationResponse: (NotificationResponse details){
      //   LogUtil.d("onDidReceiveBackgroundNotificationResponse details  ${details.toString()}");
    // }
    );
  }

  Future<bool?> _requestPermissions() async {
    if (Platform.isIOS) {
      return await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      _notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await androidImplementation?.requestNotificationsPermission();
    }
    return null;
  }

//  显示通知
  Future<void> showNotification(
      {required String title, required String body}) async {
    bool? granted=await _requestPermissions();
    if(granted==null||granted==false){
      openAppSettings();
    }
    // 安卓的通知
    // 'your channel id'：用于指定通知通道的ID。
    // 'your channel name'：用于指定通知通道的名称。
    // 'your channel description'：用于指定通知通道的描述。
    // Importance.max：用于指定通知的重要性，设置为最高级别。
    // Priority.high：用于指定通知的优先级，设置为高优先级。
    // 'ticker'：用于指定通知的提示文本，即通知出现在通知中心的文本内容。
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(channelId,channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: ticker);

    // ios的通知
    const String darwinNotificationCategoryPlain = 'plainCategory';
    const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain, // 通知分类
    );
    // 创建跨平台通知
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);

    // 发起一个通知
    await _notificationsPlugin.show(
      1,
      title,
      body,
      platformChannelSpecifics,
    );
  }

}
