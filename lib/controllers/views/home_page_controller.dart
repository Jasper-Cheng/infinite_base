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

  BMFMapOptions initMapOptions({double latitude=39.965,double longitude=116.404}) {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(latitude,longitude),
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
        showOperateLayer: false);
    return mapOptions;
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    myMapController=controller;

    /// 地图加载回调
    myMapController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
      startLocation();
    });

    /// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
    myMapController?.setMapOnDrawMapFrameCallback(callback: (BMFMapStatus mapStatus) {
//       print('地图渲染每一帧\n mapStatus = ${mapStatus.toMap()}');
    });

    /// 地图区域即将改变时会调用此接口
    /// mapStatus 地图状态信息
    myMapController?.setMapRegionWillChangeCallback(callback: (BMFMapStatus mapStatus) {
      // print('地图区域即将改变时会调用此接口1\n mapStatus = ${mapStatus.toMap()}');
    });

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    myMapController?.setMapRegionDidChangeCallback(callback: (BMFMapStatus mapStatus) {
      // print('地图区域改变完成后会调用此接口2\n mapStatus = ${mapStatus.toMap()}');
    });

    /// 地图区域即将改变时会调用此接口
    /// mapStatus 地图状态信息
    /// reason 地图改变原因
    myMapController?.setMapRegionWillChangeWithReasonCallback(callback: (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      // print('地图区域即将改变时会调用此接口3\n mapStatus = ${mapStatus.toMap()}\n reason = ${regionChangeReason.index}');
    });

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    /// reason 地图改变原因
    myMapController?.setMapRegionDidChangeWithReasonCallback(callback: (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      // print('地图区域改变完成后会调用此接口4\n mapStatus = ${mapStatus.toMap()}\n reason = ${regionChangeReason.index}');
    });
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

  Future<void> startLocation() async {
    Map iosMap = initIOSOptions().getMap();
    Map androidMap = initAndroidOptions().getMap();

    await myLocPlugin.stopLocation();
    myLocPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
      updateUserLocation(result);
      notifyListeners();
    });
    await myLocPlugin.prepareLoc(androidMap, iosMap);
    myLocPlugin.startLocation();
    myMapController?.showUserLocation(true);
  }

  /// 更新位置
  Future<void> updateUserLocation(BaiduLocation result) async {
    print("result.latitude  result.longitude ${result.latitude}  ${result.longitude}");
    double latitude=result.latitude??39.965;
    double longitude=result.longitude??116.404;
    BMFCoordinate coordinate = BMFCoordinate(latitude, longitude);
    BMFLocation location = BMFLocation(
        coordinate: coordinate,
        altitude: result.altitude,
        course: result.course,
        accuracy: result.radius,
        horizontalAccuracy: result.horizontalAccuracy,
        verticalAccuracy: result.verticalAccuracy);
    BMFUserLocation userLocation = BMFUserLocation(
      location: location,
    );
    myMapController?.updateLocationData(userLocation);
    myMapController?.updateMapOptions(
        initMapOptions(latitude:latitude,longitude:longitude)
    );
  }

  BaiduLocationAndroidOption initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
      // 定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
        locationMode: BMFLocationMode.hightAccuracy,
        // 是否需要返回地址信息
        isNeedAddress: true,
        // 是否需要返回海拔高度信息
        isNeedAltitude: true,
        // 是否需要返回周边poi信息
        isNeedLocationPoiList: true,
        // 是否需要返回新版本rgc信息
        isNeedNewVersionRgc: true,
        // 是否需要返回位置描述信息
        isNeedLocationDescribe: true,
        // 是否使用gps
        openGps: true,
        // 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
        locationPurpose: BMFLocationPurpose.sport,
        // 坐标系
        coordType: BMFLocationCoordType.bd09ll,
        // 设置发起定位请求的间隔，int类型，单位ms
        // 如果设置为0，则代表单次定位，即仅定位一次，默认为0
        scanspan: 0
    );
    return options;
  }

  BaiduLocationIOSOption initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
      // 坐标系
      coordType: BMFLocationCoordType.bd09ll,
      // 位置获取超时时间
      locationTimeout: 10,
      // 获取地址信息超时时间
      reGeocodeTimeout: 10,
      // 应用位置类型 默认为automotiveNavigation
      activityType:
      BMFActivityType.automotiveNavigation,
      // 设置预期精度参数 默认为best
      desiredAccuracy: BMFDesiredAccuracy.best,
      // 是否需要最新版本rgc数据
      isNeedNewVersionRgc: true,
      // 指定定位是否会被系统自动暂停
      pausesLocationUpdatesAutomatically: false,
      // 指定是否允许后台定位,
      // 允许的话是可以进行后台定位的，但需要项目配置允许后台定位，否则会报错，具体参考开发文档
      allowsBackgroundLocationUpdates: true,
      // 设定定位的最小更新距离
      distanceFilter: 10,
    );
    return options;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myLocPlugin.stopLocation();
  }


}