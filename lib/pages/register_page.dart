import 'package:flutter/material.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';

import '../controllers/register_page_controller.dart';

class RegisterPage extends BasePage{
  const RegisterPage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<StatefulWidget> createState() => RegisterPageState();

}
class RegisterPageState extends BasePageState{
  final RegisterPageController _controller=RegisterPageController();

  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
        showLeadingView: true,
        body: _buildBodyView()
    );
  }

  Widget _buildBodyView(){
    return Container();
  }

  @override
  BaseController initController() {
    return _controller;
  }

}