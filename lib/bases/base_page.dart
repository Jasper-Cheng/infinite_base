import 'package:flutter/material.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';
import 'package:provider/provider.dart';

import 'base_controller.dart';

abstract class BasePage extends StatefulWidget {
  final Bundle? bundle;

  const BasePage({Key? key, this.bundle}) : super(key: key);

}

abstract class BasePageState<T extends BasePage> extends State<T> with WidgetsBindingObserver {

  BaseController? baseController;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    ApplicationController().addPage(this);
    baseController = initController();
    if (baseController != null) {
      baseController!.context = context;
      baseController!.initController(this,widget.bundle);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (baseController != null) {
      return ChangeNotifierProvider(
        create: (context) => baseController,
        child: buildViews(context),
        // child: Consumer<BaseController>(
        //   builder: (BuildContext context, BaseController value, Widget? child) {
        //     return buildViews(context);
        //   },
        // )
      );
    }
    return buildViews(context);
  }
  Widget buildViews(BuildContext context);

  BaseController initController();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
