import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:lifelineapp/resources/dimen.dart';
import 'package:lifelineapp/resources/assets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextCategory extends StatefulWidget {
  @override
  TextCategoryState createState() => new TextCategoryState();
}
class TextCategoryState extends State<TextCategory>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final PageController ctrl = PageController(initialPage: 0);

  //viewportFraction: 0.8
  final Firestore db = Firestore.instance;
  Stream slides;

  int _selectedVideoHeader = 1;
  int _videoPause = 0;
  int _likedVideo = 0;
  int currentPage = 0;
  String activeTag = "for you";

  @override
  void initState() {
    _queryDb();
    ctrl.addListener((){
      int next = ctrl.page.round();
      if(currentPage != next){
        setState((){
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void _nextPage(int delta) {
    ctrl.animateToPage(
        currentPage+delta,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }
  void _handlePageChanged(int page) {
    setState(() {

    });
  }

  Stream _queryDb({String tag = 'favourites'}){
    Query query = db.collection('text').where('tags', arrayContains: tag);
    slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    setState(() {
      activeTag = tag;
    });
  }

  void _onVideoHeader(int index) {
    setState(() {
      _selectedVideoHeader = index;

      if(_selectedVideoHeader == 1){
        _queryDb(tag: "following");
      }else if(_selectedVideoHeader == 2){
        _queryDb(tag: "for you");
      }else if(_selectedVideoHeader == 3){
        _queryDb(tag: "nearby");
      }
    });
  }

  Widget _buildVideoHeader(int index, IconData icon, String tooltip) {
    return new Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: IconButton(
        icon: new Icon(icon,
          size: _selectedVideoHeader == index ? 36 : 24,
        ),
        tooltip: tooltip,
        color: _selectedVideoHeader == index ? Colors.blue : Colors.white,
        onPressed: () {
          _onVideoHeader(index);
          Fluttertoast.showToast(
            msg: "You are watching '"+tooltip+"'",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
      ),
    );
  }
  Widget _buildVideoRightSide(BuildContext context, String text, IconData icon, String display) {

    return new Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Icon(icon,
              color: _likedVideo == 0 ? Colors.white : Colors.red,
              size: 35,),
            onTap: (){
              if(text == "profile"){
                Navigator.of(context).pushNamed("/Profile");
              }else if(text == "like"){
                //_onVideoLike(1);

                Fluttertoast.showToast(
                    msg: "You liked this video",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }else if(text == "comment"){
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context){
                      return new Container(
                        padding: new EdgeInsets.all(15.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('Comments Here', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            //new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text('Close'),)
                          ],
                        ),
                      );
                    }
                );
              }else if(text == "share"){
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context){
                      return new Container(
                        padding: new EdgeInsets.all(15.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('Share Here', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            //new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text('Close'),)
                          ],
                        ),
                      );
                    }
                );
              }
              //Navigator.pushNamed(context, '/TextCategory');
            },
          ),
          Padding(
            padding:
            EdgeInsets.only(
                top: Dimen.defaultTextSpacing, bottom: Dimen.defaultTextSpacing
            ),
            child: Text(
              display,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData){
          return LinearProgressIndicator();
        }else{
          return _buildList(context, snapshot.data.documents);
        }

      },
    );
  }
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return StreamBuilder(
      stream: slides,
      initialData: [],
      builder: (context, AsyncSnapshot snap) {
        List slideList = snap.data.toList();
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: ctrl,
            onPageChanged: _handlePageChanged,
            itemCount: slideList.length,
            itemBuilder: (context, int currentIdx) {
              bool active = currentIdx == currentPage;
              return _buildStoryPage(slideList[currentIdx], active);
            }
        );
      },
    );
  }

  _buildStoryPage(Map data, bool active) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
            Center(
              child: GestureDetector(
                  child: Text(data['description'],
                      style: TextStyle(fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.grey
                      )
                  ),
              onTap: (){

              },
              onLongPress: (){
                Fluttertoast.showToast(
                    msg: "You tapped long on this video",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              onDoubleTap: (){
                Fluttertoast.showToast(
                    msg: "You liked this video",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(flex: 5, child: Container(
                  padding: EdgeInsets.only(left: 16, bottom: 60),
                )),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //userProfile(),
                        _buildVideoRightSide(context,"profile",AppIcons.profile,data['name']),
                        _buildVideoRightSide(context,"like",AppIcons.heart,data['like_count']),
                        _buildVideoRightSide(context,"comment",AppIcons.chat_bubble,data['comment_count']),
                        _buildVideoRightSide(context,"share",AppIcons.reply,data['share_count']),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //theme: ThemeData.dark(),
        home: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              _buildBody(context),

              Container(
                margin: EdgeInsets.only(top: 40),
                height: Dimen.headerHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildVideoHeader(1,Icons.favorite_border,"Following"),
                    Text("|",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal)),
                    _buildVideoHeader(2,Icons.notifications,"For You"),
                    Text("|",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal)),
                    _buildVideoHeader(3,Icons.location_on,"Near By"),
                  ],
                ),
              ),
            ],
          ),
        )
      //,
    );
  }
}
class TextWrite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //leading: Icon(Icons.add),
        title: new Text("Write Text"),
        backgroundColor: Colors.black,
      ),body: Center(

    ),
    );
  }
}