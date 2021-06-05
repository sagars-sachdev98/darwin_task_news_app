import 'package:flutter/material.dart';

class HomePageCategory {
  String title;
  String navigation;
  HomePageCategory({this.title, this.navigation});
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomePageCategory> homePageCategoryData = [
    HomePageCategory(title: 'Top Headlines', navigation: '/topHeadlines'),
    HomePageCategory(title: 'Search', navigation: '/search'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: homePageCategoryData.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return homePageCategoryCard(homePageCategoryData[index]);
          },
        ),
      ),
    );
  }

  Widget homePageCategoryCard(HomePageCategory homePageCategory) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, homePageCategory.navigation);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Text(
              homePageCategory.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
