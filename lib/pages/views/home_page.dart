import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';

import '../../controllers/views/home_page_controller.dart';

class HomePage extends BasePage {
  const HomePage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  final HomePageController _controller=HomePageController();
  AMapController? _mapController;
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(39.909187, 116.397451),
    zoom: 10.0,
  );
  List<Widget> _approvalNumberWidget = [];

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
      body: _buildBodyView(),
    );
  }
  Widget _buildBodyView(){
    final AMapWidget map = AMapWidget(
      initialCameraPosition: _kInitialPosition,
      privacyStatement: AMapPrivacyStatement(hasShow: true, hasAgree: true, hasContains: true),
      apiKey: AMapApiKey(
          androidKey: '666a1db473e67ef1061ce8a2245a83f3'
      ),
      onMapCreated: onMapCreated,
    );

    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Positioned(
              right: 10,
              bottom: 15,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _approvalNumberWidget),
              ))
        ],
      ),
    );
  }
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }

  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber =
    await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber =
    await _mapController?.getSatelliteImageApprovalNumber();
    setState(() {
      if (null != mapContentApprovalNumber) {
        _approvalNumberWidget.add(Text(mapContentApprovalNumber));
      }
      if (null != satelliteImageApprovalNumber) {
        _approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
      }
    });
    print('地图审图号（普通地图）: $mapContentApprovalNumber');
    print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }
}
