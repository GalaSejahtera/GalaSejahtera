import 'package:flutter/material.dart';
// import 'package:gala_sejahtera/screens/news_screen/news_details_screen.dart';

class NewsModelChoice {
  final String title;
  final String date;
  final String description;
  final String imglink;

  const NewsModelChoice(
      {this.title, this.date, this.description, this.imglink});
}

class NewsLayoutScreen extends StatefulWidget {
  @override
  _NewsLayoutScreenState createState() => _NewsLayoutScreenState();
}

class _NewsLayoutScreenState extends State<NewsLayoutScreen> {
  final TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search News');
  List filteredNames = new List(); // names filtered by search text
  List names = new List();
  String _searchText = "";

  List newsModelChoice = const [
    const NewsModelChoice(
        title: 'MacBook Pro',
        date: '1 June 2019',
        description:
            'MacBook Pro (sometimes abbreviated as MBP) is a line of Macintosh portable computers introduced in January 2006 by Apple Inc.',
        imglink:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    const NewsModelChoice(
        title: 'MacBook Air',
        date: '1 June 2016',
        description:
            'MacBook Air is a line of laptop computers developed and manufactured by Apple Inc. It consists of a full-size keyboard, a machined aluminum case, and a thin light structure.',
        imglink:
            'https://images.unsplash.com/photo-1499673610122-01c7122c5dcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    const NewsModelChoice(
        title: 'iMac',
        date: '1 June 2019',
        description:
            'iMac is a family of all-in-one Macintosh desktop computers designed and built by Apple Inc. It has been the primary part of Apple consumer desktop offerings since its debut in August 1998, and has evolved through seven distinct forms.',
        imglink:
            'https://images.unsplash.com/photo-1517059224940-d4af9eec41b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    const NewsModelChoice(
        title: 'Mac Mini',
        date: '1 June 2017',
        description:
            'Mac mini (branded with lowercase "mini") is a desktop computer made by Apple Inc. One of four desktop computers in the current Macintosh lineup, along with the iMac, Mac Pro, and iMac Pro, it uses many components usually featured in laptops to achieve its small size.',
        imglink:
            'https://www.apple.com/v/mac-mini/f/images/shared/og_image__4mdtjbfhcduu_large.png?201904170831'),
    const NewsModelChoice(
        title: 'Mac Pro',
        date: '1 June 2018',
        description:
            'Mac Pro is a series of workstation and server computer cases designed, manufactured and sold by Apple Inc. since 2006. The Mac Pro, in most configurations and in terms of speed and performance, is the most powerful computer that Apple offers.',
        imglink:
            'https://i0.wp.com/9to5mac.com/wp-content/uploads/sites/6/2017/01/mac-pro-2-concept-image.png?resize=1000%2C500&quality=82&strip=all&ssl=1'),
  ];

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
        body: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: List.generate(newsModelChoice.length, (index) {
              return Center(
                child: NewsChoiceCard(
                  newsModelChoice: newsModelChoice[index],
                  item: newsModelChoice[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                              newsDetailChoice: newsModelChoice[index])),
                    );
                  },
                ),
              );
            })),
      ),
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
                      Text(newsModelChoice.date,
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

class NewsDetailScreen extends StatelessWidget {
  final NewsModelChoice newsDetailChoice;
  NewsDetailScreen({this.newsDetailChoice});
  final Color gradientStart = Colors.transparent;
  final Color gradientEnd = Colors.black;

  Widget _buildImageContainer(String imgLink, String newsTitle) {
    return Stack(children: <Widget>[
      ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.black.withAlpha(0),
              Colors.black12,
              Colors.black87
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.darken,
        child: Image.network(
          imgLink,
          // height: ,
          fit: BoxFit.contain,
        ),
      ),
      // Container(
      //   height: 300,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //         colorFilter: new ColorFilter.mode(
      //             Colors.black.withOpacity(0.7), BlendMode.dstATop),
      //         image: NetworkImage(imgLink),
      //         fit: BoxFit.fitHeight),
      //   ),
      // ),
      Positioned(
        bottom: 15,
        right: 15,
        child: Icon(
          Icons.share,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      Positioned(
        bottom: 15,
        left: 15,
        child: Text(
          newsTitle,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsDetailChoice.title),
      ),
      backgroundColor: Color(0xff60A1DD),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            child: Column(children: [
              Column(
                children: <Widget>[
                  // Text("${newsDetailChoice.title}"),
                  // Center(
                  //   child: RaisedButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Text('Go back!'),
                  //   ),
                  // ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: _buildImageContainer(
                        newsDetailChoice.imglink, newsDetailChoice.title),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  // Expanded(
                  //   child: Text(
                  //     newsDetailChoice.description,
                  //     style: TextStyle(
                  //       fontSize: 16.0, // insert your font size here
                  //     ),
                  //   ),
                  // ),
                  Container(
                    // height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        newsDetailChoice.description,
                        style: TextStyle(
                          fontSize: 16.0, // insert your font size here
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]),
          )),
    );
  }
}