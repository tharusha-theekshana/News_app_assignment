import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';

import '../controller/news_controller.dart';
import '../model/news.dart';
import '../utils/colors.dart';
import '../widgets/list_item.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({required this.searchText});

  late double _deviceWidth, _deviceHeight;

  final newsController = Get.put(NewsController());

  final String searchText;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(searchText.toString(), style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.primaryColor,
                fontSize: 15.0
              ),),
            ),
            body: FutureBuilder(
              future: newsController.getSearchNews(searchText: searchText),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListItems(list: snapshot.data as List<News>, scrolldirection: Axis.vertical,height:_deviceHeight * 0.25 ,width: _deviceWidth * 0.5,);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
        );
      },
    );

  }
}
