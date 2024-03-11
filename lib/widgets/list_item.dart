import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';

import '../model/news.dart';
import '../screens/news_item_page.dart';

class ListItems extends StatelessWidget {

  ListItems({required this.list,required this.scrolldirection,required this.width,required this.height});

  late double _height, _width;
  final List<News> list;
  final Axis scrolldirection;
  final double height;
  final double width;

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: list.length,
      scrollDirection: scrolldirection,
      itemBuilder: (context, index) {
        if(list.isNotEmpty){
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsItemPage(news: list[index],)),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: _width * 0.02, vertical: _height * 0.01),
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          list[index].urlToImage.toString()
                      ),
                      fit: BoxFit.cover)),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _width,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                    list[index].title.toString() ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white
                    )
                ),
              ),
            ),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(
                color: Colors.black
            ),
          );
        }
      },
    );
  }
}
