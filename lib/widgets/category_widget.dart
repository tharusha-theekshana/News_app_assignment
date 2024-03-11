import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/news_controller.dart';
import '../model/news.dart';
import '../shared/category.dart';
import '../utils/colors.dart';
import 'list_item.dart';

class CategoryWidget extends StatefulWidget {

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  late double _deviceHeight, _deviceWidth;
  late TabController tabController;
  final newsController = Get.put(NewsController());

  @override
  void initState() {
    tabController =
        TabController(length: Category.categoryItems.length, vsync: this);
    super.initState();
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    _deviceHeight= MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: tabController,
            indicatorColor: box.read("theme") == "dark" ? Colors.white : Colors.primaryColor,
            tabs: Category.categoryItems.map((e) {
              return Container(
                child: Text(e , style: TextStyle(
                  color: box.read("theme") == "dark" ? Colors.white : Colors.primaryColor,
                ),),
              );
            }).toList(),
          ),
          SizedBox(height: _deviceHeight * 0.02,),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: Category.categoryItems.map((e) {
                return FutureBuilder(
                  future: newsController.getCategoryNews(category: e),
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
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
