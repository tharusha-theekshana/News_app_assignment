import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app_assignment/screens/search_screen.dart';


import '../controller/news_controller.dart';
import '../model/news.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/category_widget.dart';
import '../widgets/home_widget.dart';
import 'login_page.dart';
import 'notification_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late double _deviceWidth, _deviceHeight;

  late TextEditingController controller;
  String searchText = '';

  final box = GetStorage();

  final newsController = Get.put(NewsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          _topBar(),
          _latestNews(),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          Expanded(child: CategoryWidget()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
        },
        backgroundColor: Colors.primaryColor,
        child: Icon(
          Icons.logout,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _topBar() {
    return SafeArea(
      child: Container(
        width: _deviceWidth * 0.95,
        padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: _deviceWidth * 0.65,
              height: _deviceHeight * 0.055,
              child: SearchBar(
                onSubmitted: (value) {
                  searchText = value;
                  newsController.getSearchNews(searchText: value);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen(searchText: searchText);
                  },));
                  controller.clear();
                },
                padding: MaterialStateProperty.resolveWith((states) {
                  return EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03);
                }),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors
                        .primaryColor; // Color when the widget is pressed
                  } else {
                    return Colors.white;
                  }
                }),
                hintText: "Search",
                hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                        (Set<MaterialState> states) {
                      return TextStyle(
                        color: Colors.grayLight,
                        fontStyle: FontStyle.italic,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      );
                    }),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                        (Set<MaterialState> states) {
                      return TextStyle(
                        color: Colors.gray,
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                      );
                    }),
                controller: controller,
                trailing: [
                  Icon(Icons.search, color: Colors.gray),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.primaryColor),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            newsController.changeThemeMode();
                          });
                        },
                        icon: Icon(newsController.iconTheme())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _latestNews() {
    return Container(
      height: _deviceHeight * 0.3,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Latest News", style: Styles.latestNewsText),
                Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: _deviceWidth * 0.04,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 15.0,
                      color: Colors.blue,
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(child: HomeWidget(height: _deviceHeight * 0.3, width: _deviceWidth * 0.6,scrolldirection: Axis.horizontal),),
        ],
      ),
    );
  }
}
