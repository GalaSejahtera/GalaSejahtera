import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _emptyNewsListText = new Text('No Result!',
      style : TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      fontFamily: 'Open Sans',
      fontSize: 40
      ));
  SearchBar searchBar;

  // Icon _searchIcon = new Icon(Icons.search);

  // List filteredNames = new List(); // names filtered by search text
  // List names = new List();
  // String _searchText = "";

  ScrollController _sc = new ScrollController();
  String searchText = "";
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
     searchText = "";

     this.fetchNewsRecord(from, to, searchText);

     _sc.addListener(() {
       if(_sc.position.pixels == _sc.position.maxScrollExtent) {
         fetchNewsRecord(from, to, searchText);
       }
     });
  }

  Future<void> fetchNewsRecord(int fromItem, int toItem, [String searchValue]) async{
    NewsRecords fetchedNews = new NewsRecords();
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      fetchedNews = await restApiServices.fetchNewsRecords(fromItem.toString(), toItem.toString(), searchValue);
    }

    setState(() {
      isLoading = false;
      newsList = [ ...newsList, ...fetchedNews.newsModel.toList()];
      from = fromItem + pageIncrement;
      to = toItem + pageIncrement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: Scaffold(
        appBar: searchBar.build(context),
        key: _scaffoldKey,
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

  Widget _buildEmptyNewsListIndicator() {
    return Container(
      child: Center(
        child: Column(
          children: [
            new Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network("https://img.icons8.com/cotton/2x/empty-box.png")
            ),
            _emptyNewsListText,
          ],
        )
      ),
    );
  }

  Widget _buildNewsList(){
      if(newsList.length == 0 && !isLoading) {
        return _buildEmptyNewsListIndicator();
      }

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

  void onSubmitted(String value) async {
    // reset to initial page state
    int start = 0;
    int end = 9;
    var newsRecords = await restApiServices.fetchNewsRecords(start.toString(), end.toString(), value);
    setState(() {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Search : $value')));
      from = start + pageIncrement;
      to = end + pageIncrement;
      newsList = [...newsRecords.newsModel.toList()];
      searchText = value;
    });
  }

  _NewsLayoutScreenState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: _buildNewsBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        },
        // showClearButton: true,
    );
  }

  void _clearSearchText() async {
    int start = 0;
    int end = 0;

    var newsRecords = await restApiServices.fetchNewsRecords(start.toString(), end.toString(), "");
    setState(() {
      from = start + pageIncrement;
      to = end + pageIncrement;
      newsList = [...newsRecords.newsModel.toList()];
      searchText = "";
    });
  }

  AppBar _buildNewsBar(BuildContext context) {
    var _actionsList = [searchBar.getSearchAction(context)];
    var barsText = 'Search News';
    if(searchText.length > 0) {
      barsText = searchText;
      _actionsList = [searchBar.getSearchAction(context),
        IconButton(icon: Icon(Icons.cancel), onPressed: _clearSearchText),
      ];
    }

    return new AppBar(
      centerTitle: false,
      title: new Text(barsText),
        actions: _actionsList
      // leading: new IconButton(
      //   icon: _searchIcon,
      //   onPressed: _searchPressed,
      // ),
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
