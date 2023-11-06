import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

import '../../controllers/views/home_page_controller.dart';

class HomePage extends BasePage {
  const HomePage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  final HomePageController _controller=HomePageController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return AnnotatedRegion(
      child: Scaffold(
        body: Center(
          child: GestureDetector(
            child: Text("HomePage"),
            onTap: (){
              context.pop("I'm main home page,nice to meet you!");
            },
          ),
        ),
      ),
      value: SystemUiOverlayStyle.dark,
    );
  }
}
