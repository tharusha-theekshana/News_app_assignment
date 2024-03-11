import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../controller/news_controller.dart';
import '../utils/colors.dart';
import '../widgets/list_item.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  late double _deviceWidth, _deviceHeight;

  final newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Top Headlines", style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.primaryColor
        ),),
        iconTheme: IconThemeData(
          color: Colors.primaryColor, // Set the color of the icons
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _deviceHeight,
            width: _deviceWidth,
            child: ListItems(
                list: newsController.news, scrolldirection: Axis.vertical,width: _deviceWidth,height: _deviceHeight * 0.3,)),
      ),
    );
  }
}
