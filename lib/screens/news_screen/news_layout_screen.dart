import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/news_records.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
// import 'package:gala_sejahtera/screens/news_screen/news_details_screen.dart';
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
  _NewsLayoutScreenState createState() => _NewsLayoutScreenState();
}

class _NewsLayoutScreenState extends State<NewsLayoutScreen> {
  RestApiServices restApiServices = RestApiServices();
  final TextEditingController _filter = new TextEditingController();
  Future<NewsRecords> newsRecord;

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search News');
  List filteredNames = new List(); // names filtered by search text
  List names = new List();
  String _searchText = "";

  @override
  void initState() {
     super.initState();
     newsRecord = fetchNewsRecord();
  }

  Future<NewsRecords> fetchNewsRecord() async{
    return await restApiServices.fetchNewsRecords();
  }

  SearchNewsState() {
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

  // Function to be called on click
  void _onTileClicked(int index) {
    setState(() {});
    debugPrint("You tapped on item $index");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: Scaffold(
        appBar: _buildNewsBar(context),
        backgroundColor: Color(0xff60A1DD),
        body: Center(
          child: _newsRecordData(),
        )
      ),
    );
  }

  ListView _newsRecords(data) {
    return ListView.builder(
        itemCount: data.newsModel.length,
        itemBuilder: (context, index) {
          var newsDate = "";
          final newsDatetime = DateTime.fromMillisecondsSinceEpoch(int.parse(data.newsModel[index].date_pub2));
          final currentDatetime = DateTime.now();

          if(currentDatetime.difference(newsDatetime).inDays < 1) {
            newsDate = Jiffy(newsDatetime).fromNow();
          }
          else {
            newsDate = Jiffy(newsDatetime).yMMMMdjm;
          }

          var newsModelChoice = NewsModelChoice(
              title: data.newsModel[index].title,
              date: newsDate,
              description: data.newsModel[index].summary,
              imglink: data.newsModel[index].image_feat_single,
              newsUrl: data.newsModel[index].newsUrl,
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
    );
  }

  FutureBuilder _newsRecordData() {
    return FutureBuilder<NewsRecords>(
      future: fetchNewsRecord(),
      builder: (BuildContext context, AsyncSnapshot<NewsRecords> snapshot){
        if (snapshot.hasData) {
          return _newsRecords(snapshot.data);
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

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

// class NewsDetailScreen extends StatelessWidget {
//   final NewsModelChoice newsDetailChoice;
//   NewsDetailScreen({this.newsDetailChoice});
//   final Color gradientStart = Colors.transparent;
//   final Color gradientEnd = Colors.black;
//
//   Widget _buildImageContainer(String imgLink, String newsTitle) {
//     return Stack(children: <Widget>[
//       ShaderMask(
//         shaderCallback: (rect) {
//           return LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: <Color>[
//               Colors.black.withAlpha(0),
//               Colors.black12,
//               Colors.black87
//             ],
//           ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
//         },
//         blendMode: BlendMode.darken,
//         child: Image.network(
//           imgLink,
//           // height: ,
//           fit: BoxFit.contain,
//         ),
//       ),
//       // Container(
//       //   height: 300,
//       //   decoration: BoxDecoration(
//       //     image: DecorationImage(
//       //         colorFilter: new ColorFilter.mode(
//       //             Colors.black.withOpacity(0.7), BlendMode.dstATop),
//       //         image: NetworkImage(imgLink),
//       //         fit: BoxFit.fitHeight),
//       //   ),
//       // ),
//       Positioned(
//         bottom: 15,
//         right: 15,
//         child: Icon(
//           Icons.share,
//           color: Colors.white.withOpacity(0.7),
//         ),
//       ),
//       Positioned(
//         bottom: 15,
//         left: 15,
//         child: Text(
//           newsTitle,
//           style: TextStyle(fontSize: 16, color: Colors.white),
//         ),
//       ),
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(newsDetailChoice.title),
//       ),
//       backgroundColor: Color(0xff60A1DD),
//       body: Padding(
//           padding: EdgeInsets.all(0),
//           child: Container(
//             child: Column(children: [
//               Column(
//                 children: <Widget>[
//                   // Text("${newsDetailChoice.title}"),
//                   // Center(
//                   //   child: RaisedButton(
//                   //     onPressed: () {
//                   //       Navigator.pop(context);
//                   //     },
//                   //     child: Text('Go back!'),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   Container(
//                     child: _buildImageContainer(
//                         newsDetailChoice.imglink, newsDetailChoice.title),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   // Expanded(
//                   //   child: Text(
//                   //     newsDetailChoice.description,
//                   //     style: TextStyle(
//                   //       fontSize: 16.0, // insert your font size here
//                   //     ),
//                   //   ),
//                   // ),
//                   Container(
//                     // height: MediaQuery.of(context).size.height,
//                     color: Colors.white,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         newsDetailChoice.description,
//                         style: TextStyle(
//                           fontSize: 16.0, // insert your font size here
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ]),
//           )),
//     );
//   }
// }
