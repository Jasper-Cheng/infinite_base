import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

import '../../controllers/views/home_page_controller.dart';

class HomePage extends BasePage {
  const HomePage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  final HomePageController _controller = HomePageController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return _buildBodyView();
  }

  Widget _buildBodyView() {
    return BMFMapWidget(
      onBMFMapCreated: _controller.onBMFMapCreated,
      mapOptions: _controller.initMapOptions(),
    );
  }
}
