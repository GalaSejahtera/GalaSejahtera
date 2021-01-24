import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/news_records.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:jiffy/jiffy.dart';
import 'news_details_screen.dart';

class NewsModelChoice {
  final String title;
  final String date;
  final String description;
  final String imglink;
  final String newsUrl;

  const NewsModelChoice({this.title, this.date, this.description, this.imglink, this.newsUrl});
}

class NewsLayoutScreen extends StatefulWidget {
  @override
  _NewsLayoutScreenState createState() => new _NewsLayoutScreenState();
}

class _NewsLayoutScreenState extends State<NewsLayoutScreen> {
  RestApiServices restApiServices = RestApiServices();
  final TextEditingController _filter = new TextEditingController();

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search News');
  List filteredNames = new List(); // names filtered by search text
  List names = new List();
  String _searchText = "";

  ScrollController _sc = new ScrollController();
  List newsList = [];
  static int from = 0;
  static int to = 9;
  static int pageIncrement = 10;
  bool isLoading = false;

  @override
  void initState() {
     super.initState();
     from = 0;
     to = 9;
     isLoading = false;
     _searchText = "";

     this.fetchNewsRecord(from, to);

     _sc.addListener(() {
       if(_sc.position.pixels == _sc.position.maxScrollExtent) {
         fetchNewsRecord(from, to);
       }
     });
  }

  Future<void> fetchNewsRecord(int fromItem, int toItem) async{
    NewsRecords fetchedNews = new NewsRecords();
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      fetchedNews = await restApiServices.fetchNewsRecords(fromItem.toString(), toItem.toString());
    }
    setState(() {
      isLoading = false;
      newsList = [ ...newsList, ...fetchedNews.newsModel.toList()];
      from = fromItem + pageIncrement;
      to = toItem + pageIncrement;
    });
  }

  searchNewsState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: Scaffold(
        appBar: _buildNewsBar(context),
        backgroundColor: Color(0xff60A1DD),
        body: Center(
          child: _buildNewsList(),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildNewsList(){
      return ListView.builder(
          controller: _sc,
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == newsList.length) {
              return _buildProgressIndicator();
            }
            else {
              var newsDate = "";
              final newsDatetime = DateTime.fromMillisecondsSinceEpoch(int.parse(newsList[index].date_pub2));
              final currentDatetime = DateTime.now();

              if(currentDatetime.difference(newsDatetime).inDays < 1) {
                newsDate = Jiffy(newsDatetime).fromNow();
              }
              else {
                newsDate = Jiffy(newsDatetime).yMMMMdjm;
              }

              var newsModelChoice = NewsModelChoice(
                title: newsList[index].title,
                date: newsDate,
                description: newsList[index].summary,
                imglink: newsList[index].image_feat_single,
                newsUrl: newsList[index].newsUrl,
              );

              return Center(
                child: NewsChoiceCard(
                  newsModelChoice: newsModelChoice,
                  item: newsModelChoice,
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(newsDetailChoice: newsModelChoice)),
                    );
                  },
                ),
              );
            }
          }
      );
  }

  // FutureBuilder _newsRecordData() {
  //   return FutureBuilder<NewsRecords>(
  //     future: fetchNewsRecord(page),
  //     builder: (BuildContext context, AsyncSnapshot<NewsRecords> snapshot){
  //       if (snapshot.hasData) {
  //         return _newsRecords(snapshot.data);
  //       }else {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search News');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  Widget _buildNewsBar(BuildContext context) {
    return new AppBar(
      centerTitle: false,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }
}

class NewsChoiceCard extends StatelessWidget {
  const NewsChoiceCard(
      {Key key,
      this.newsModelChoice,
      @required this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final NewsModelChoice newsModelChoice;

  final VoidCallback onTap;

  final NewsModelChoice item;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return InkWell(
        onTap: () {
          onTap();
        },
        child: Card(
            color: Colors.white,
            child: Column(
              children: [
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(newsModelChoice.imglink)),
                new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(newsModelChoice.title,
                          style: Theme.of(context).textTheme.title),
                      Text(newsModelChoice.date.toString(),
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5))),
                      Text(newsModelChoice.description),
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}
