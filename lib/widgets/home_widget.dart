import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/news_controller.dart';
import 'list_item.dart';



class HomeWidget extends StatelessWidget {

  late double _deviceHeight, _deviceWidth;
  final Axis scrolldirection;
  final double height;
  final double width;

  HomeWidget({required this.scrolldirection,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {

    _deviceHeight= MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) {
        return ListItems(list: controller.news,scrolldirection: scrolldirection,width: width,height: height,);
      },
    );
  }


}
