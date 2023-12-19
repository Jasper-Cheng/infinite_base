import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFEdgeInsets, BMFLogoPosition, BMFMapSDK, BMFMapType, BMFRegionChangeReason, BMF_COORD_TYPE;

class HomePageController extends BaseController{

  LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
  BMFMapController? myMapController;

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {
      /// 动态申请定位权限
      requestPermission();
      initBaiDuSdk();
    });
  }


  Future<void> initBaiDuSdk() async {
    BMFMapSDK.setAgreePrivacy(true);
    myLocPlugin.setAgreePrivacy(true);
    if (Platform.isIOS) {
      myLocPlugin.authAK('ptNTjqGNOcBuEGswusb6rgGZsvfE1SQT');
      BMFMapSDK.setApiKeyAndCoordType('ptNTjqGNOcBuEGswusb6rgGZsvfE1SQT', BMF_COORD_TYPE.BD09LL);
    } else if (Platform.isAndroid) {
      await BMFAndroidVersion.initAndroidVersion();
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    }
  }

  // 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      // 权限申请通过
    } else {}
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  BMFMapOptions initMapOptions() {
    BMFCoordinate center = BMFCoordinate(39.965, 116.404);
    BMFMapOptions mapOptions = BMFMapOptions(
        mapType: BMFMapType.Standard,
        zoomLevel: 12,
        maxZoomLevel: 21,
        minZoomLevel: 4,
        buildingsEnabled: true,
        backgroundColor: Colors.blue,
        logoPosition: BMFLogoPosition.LeftBottom,
        mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
        overlookEnabled: true,
        overlooking: -15,
        center: center,
        showOperateLayer: false);
    return mapOptions;
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    myMapController=controller;

    /// 地图加载回调
    myMapController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });

    /// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
    myMapController?.setMapOnDrawMapFrameCallback(callback: (BMFMapStatus mapStatus) {
//       print('地图渲染每一帧\n mapStatus = ${mapStatus.toMap()}');
    });

    /// 地图区域即将改变时会调用此接口
    /// mapStatus 地图状态信息
    myMapController?.setMapRegionWillChangeCallback(callback: (BMFMapStatus mapStatus) {
      print('地图区域即将改变时会调用此接口1\n mapStatus = ${mapStatus.toMap()}');
    });

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    myMapController?.setMapRegionDidChangeCallback(callback: (BMFMapStatus mapStatus) {
      print('地图区域改变完成后会调用此接口2\n mapStatus = ${mapStatus.toMap()}');
    });

    /// 地图区域即将改变时会调用此接口
    /// mapStatus 地图状态信息
    /// reason 地图改变原因
    myMapController?.setMapRegionWillChangeWithReasonCallback(callback: (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      print(
          '地图区域即将改变时会调用此接口3\n mapStatus = ${mapStatus.toMap()}\n reason = ${regionChangeReason.index}');
    });

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    /// reason 地图改变原因
    myMapController?.setMapRegionDidChangeWithReasonCallback(callback: (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      print(
          '地图区域改变完成后会调用此接口4\n mapStatus = ${mapStatus.toMap()}\n reason = ${regionChangeReason.index}');
    });
  }


}