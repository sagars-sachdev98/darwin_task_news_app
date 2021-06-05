import 'package:darwin_task/models/headlines.model.dart';
import 'package:darwin_task/services/headline.service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlines extends StatefulWidget {
  const TopHeadlines({Key key}) : super(key: key);

  @override
  _TopHeadlinesState createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  List<Headlines> topHeadlines = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    shimmerLoading();
    await HeadlineService().getTopHeadlines().then((headlines) {
      removeShimmerLoading();
      if (headlines.length > 0) {
        headlines.forEach((headline) {
          setState(() {
            topHeadlines.add(headline);
          });
        });
      }
    });
  }

  shimmerLoading() {
    Headlines temp = new Headlines();
    temp.isLoading = true;
    int i = 0;
    for (i = 0; i < 10; i++) {
      topHeadlines.add(temp);
    }

    setState(() {});
  }

  removeShimmerLoading() {
    topHeadlines.removeWhere((facility) => facility.isLoading);
  }

  Future<void> _getData() async {
    Future.delayed(Duration.zero, () {
      setState(() {
        topHeadlines.clear();
      });
      this.loadData();
    }).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _getData();
        },
        child: ListView.builder(
          itemCount: topHeadlines.length,
          itemBuilder: (context, index) {
            return homePageCategoryCard(topHeadlines[index]);
          },
        ),
      ),
    );
  }

  Widget homePageCategoryCard(Headlines headline) {
    return headline.isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                elevation: 8,
                child: Container(
                  height: 130,
                  width: double.infinity,
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, homePageCategory.navigation);
              },
              child: Card(
                elevation: 8,
                child: Row(
                  children: [
                    Expanded(
                        child: headline.urlToImage == null ||
                                headline.urlToImage == '' ||
                                headline.urlToImage == 'null'
                            ? Image.asset(
                                'assets/no-image.png',
                                fit: BoxFit.fitHeight,
                              )
                            : CachedNetworkImage(
                                imageUrl: headline.urlToImage.toString(),
                                fit: BoxFit.fitHeight,
                              )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                headline.source?.name ?? '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                headline?.title ?? '',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                headline?.description ?? '',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
