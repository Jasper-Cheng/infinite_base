import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/configs/url_config.dart';
import 'package:infinite_base/models/user_model.dart';
import 'package:infinite_base/network/method.dart';
import 'package:infinite_base/utils/log_util.dart';
import 'package:infinite_base/utils/network_util.dart';
import 'package:infinite_base/utils/toast_util.dart';

import '../../bases/bundle.dart';

class MyPageController extends BaseController{
  UserModel? userModel;
  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {
      getMyWife();
    });
  }

  Future<void> getMyWife() async {
    Map<String, dynamic> data = {};
    data["url"]="https://url.cn/59WAm1B";
    // FormData formData = FormData.fromMap(data);
    EasyLoading.show(status: 'loading...');
    await NetWorkUtil.instance.request<UserModel>(
        Method.GET,
        UrlConfig.getMyWife,
        queryData: data,
        successCallback: (entity) async {
          // LogUtil.d("MyPageController-getMyWife successCallback entity.msg=${entity.msg}");
          userModel=entity.data;
        },
        errorCallback: (e) async {
          ToastUtil.showToast("MyPageController-getMyWife errorCallback e=${e.msg}");
        }
    );
    EasyLoading.dismiss();
    notifyListeners();
  }

}