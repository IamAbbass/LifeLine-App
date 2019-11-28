import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:lifelineapp/bottom_nav_bar.dart';
import 'package:lifelineapp/resources/dimen.dart';
import 'package:lifelineapp/animations/spinner_animation.dart';
import 'package:lifelineapp/resources/assets.dart';
import 'package:lifelineapp/widgets/home/audio_spinner_icon.dart';
import 'package:video_player/video_player.dart';
import 'package:lifelineapp/classes/category.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lifelineapp/profile.dart';
import 'package:lifelineapp/me.dart';
import 'package:lifelineapp/discover.dart';
import 'package:lifelineapp/inbox.dart';
import 'package:lifelineapp/picture.dart';
import 'package:lifelineapp/radio.dart';
import 'package:lifelineapp/programs.dart';

import 'package:lifelineapp/text_category.dart';

import 'package:lifelineapp/firestore_doc.dart';

//import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppMain createState() => new MyAppMain();
}
class MyAppMain extends State<MyApp> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final PageController ctrl = PageController(initialPage: 0);

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _handlePageChanged(int page) {
    setState(() {

      if(_controller != null) {
        if(_controller.value.isPlaying){
          _controller.pause();
        }
      }

      _controller = VideoPlayerController.asset("assets/videos/" + (page.toString()) + ".mp4");

      /*..initialize().then((_) {

      });
      */

      _initializeVideoPlayerFuture = _controller.initialize();

      _controller.setLooping(true);
      _controller.setVolume(1);
      _controller.play();

      super.initState();

    });
  }

  Stream _queryDb({String tag = 'following'}){
    
    Query query = db.collection('stories').where('tags', arrayContains: tag);

    slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
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
  void _onVideoPause() {
    setState(() {
      print(_videoPause);
    });
  }
  void _onVideoLike() {
    setState(() {
      print(_likedVideo);
    });
  }
  void _onVideoTap() {
    setState(() {
      if(_controller.value.isPlaying){
        _controller.pause();
      }else{
        _controller.play();
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
                print(text);

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
      stream: Firestore.instance.collection('stories').snapshots(),
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
            pageSnapping: true,
            scrollDirection: Axis.vertical,
            controller: ctrl,
            onPageChanged: _handlePageChanged,
            itemCount: slideList.length, //+1
            itemBuilder: (context, int currentIdx) {
              //if (currentIdx == 0) {
                //return _buildTagPage();
              //} else if (slideList.length >= currentIdx) {
                bool active = currentIdx == currentPage;
                return _buildStoryPage(slideList[currentIdx], active); //-1
              //}
            }
        );
      },
    );
  }

  _buildStoryPage(Map data, bool active) {
    // Animated Properties
    /*
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;
    */

    /*
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data['img']),
          ),
          boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]

      ),
      */

      return Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            backgroundVideo(),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(flex: 5, child: Container(
                    padding: EdgeInsets.only(left: 16, bottom: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 7, bottom: 7),
                          child: Text(
                            data['username'],
                            style: TextStyle(
                                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4, bottom: 7),
                          child: Text(data['description'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.music_note,
                              size: 19,
                              color: Colors.white,
                            ),
                            Text(
                                data['music'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ],
                    ),
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
                          SpinnerAnimation(body: audioSpinner())
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

  _buildTagPage() {
    return Container(
        color: Colors.black,
        child:

    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Life Line', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
        Text('Filter Videos', style: TextStyle(color: Colors.white )),
        _buildButton('following'),
        _buildButton('for you'),
        _buildButton('nearby')
      ],
    )
    );
  }
  _buildButton(tag) {
    Color bg_color = tag == activeTag ? Colors.blue : Colors.white;
    Color txt_color = tag == activeTag ? Colors.white : Colors.blue;
    return FlatButton(color: bg_color, child: Text('#$tag', style: TextStyle(color: txt_color),), onPressed: () => _queryDb(tag: tag));
  }

  Widget backgroundVideo() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: GestureDetector(
                onTap: (){
                  _onVideoTap();
                },
                onLongPress: (){
                  _onNextVideoBounce();
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
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Future < void > postVideo() async {
    await db.collection("stories").add({
      'comment_count': "0",
      'like_count': "0",
      'share_count': "0",
      'description': "Some text here for this video",
      'music': "Balay Balay Chawa Chawa",
      'name': "@abbass",
      'tags': ['following','for you','nearby',],
      'uid': "UID",
      'username': "@abbass",
      'video': "1.mp4",
    }).then((documentReference) {
      print(documentReference.documentID);
    }).catchError((e) {
      print(e);
    });
  }

  void _onNextVideo() {
    ctrl.animateToPage(
        currentPage+1,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease
    );
  }

  void _onNextVideoBounce() {
    ctrl.animateToPage(
        currentPage+1,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/Menu': (context) => Menu(),
        '/Discover': (context) => Discover(),
        '/PlusVideo': (context) => PlusVideo(),
        '/Inbox': (context) => FriendsListPage(),
        '/Me': (context) => Me(),
        '/Profile': (context) => Profile(),
        '/TextCategory': (context) => TextCategory(),
        '/PictureCategory': (context) => PictureCategory(),
        '/Radio': (context) => RadioCategory(),
        '/Program': (context) => ProgramCategory(),
      },
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: Scaffold(
        //key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            _buildBody(context),
            BottomNavigation(),
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

                  //Text("|",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal)),
                  /*
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: IconButton(
                      icon: new Icon(Icons.skip_next,
                        size:36,
                      ),
                      tooltip: "Next",
                      color: Colors.white,
                      onPressed: () {
                        _onNextVideo();
                      },
                    ),
                  )
                  */
                ],
              ),
            ),
          ],
        ),
          /*
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
                postVideo();
            },
            tooltip: 'Write New',
            icon: Icon(Icons.check),
            label: Text("Save"),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          */
      )
      //,
    );
  }
}

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: Colors.blue,
        //leading: Icon(Icons.person),
      ),
      body: new GridView.builder(
          itemCount: choices.length,
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
    
              child: new Card(
                //shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.teal)),
                //elevation: 3.0,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Text(""),
                      new Icon(
                        choices[index].icon,
                        size: 36,
                        color: Colors.blue,
                      ),
                      new Text(
                          choices[index].title,
                          style: TextStyle(fontSize: 18, color: Colors.blue),

                      ),
                      new Text(" "),
                      new Text(
                        choices[index].subtitle,
                        style: TextStyle(fontSize: 12, color: Colors.blueGrey),

                      ),
                      //new Text(choices[index].subtitle),
                    ],
                  ),
                ),
              ),
              onLongPress: (){
                return
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    child: new CupertinoAlertDialog(
                      title: new Column(
                        children: <Widget>[
                          new Icon(
                            choices[index].icon, size: 36,
                            color: Colors.black,
                          ),
                          new Text(choices[index].title),
                        ],
                      ),
                      content: new Text(choices[index].subtitle),
                      actions: <Widget>[
                        new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryPage(category: choices[index]),
                                ),
                              );*/

                              final snackBar = SnackBar(
                                content: Text('Yay! You liked '+choices[index].title+" category !"),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              // Find the Scaffold in the widget tree and use
                              // it to show a SnackBar.
                              Scaffold.of(context).showSnackBar(snackBar);

                            },
                            child: new Text("♥"))
                      ],
                    ),
                  );

                  /*showDialog(
                    context: context,
                    child: new AlertDialog(
                      title: new Text(choices[index].title),
                      content: new Text(choices[index].subtitle),
                      actions: <Widget>[
                        new FlatButton(onPressed: () => Navigator.pop(context), child: new Text('Okay'))
                      ],
                    )
                );*/
              },
              onTap: () {
                if(index == 0){ //HOME
                  Navigator.pushNamed(context, '/');
                }else if(index == 1){ //Mugic
                  Navigator.pushNamed(context, '/');
                }else if(index == 2){ //Radio
                  Navigator.pushNamed(context, '/Radio');
                }else if(index == 3){ //Programs
                  Navigator.pushNamed(context, '/Program');
                }else if(index == 4){ //Picture
                  Navigator.pushNamed(context, '/PictureCategory');
                }else if(index == 5){ //Vlogs
                  Navigator.pushNamed(context, '/');
                }else if(index == 7){ //Stories
                  Navigator.pushNamed(context, '/');
                }else if(index == 8){ //Memes
                  Navigator.pushNamed(context, '/');
                }else if(index == 9){ //Text
                  Navigator.pushNamed(context, '/TextCategory');
                }else if(index == 10){ //Cartoon
                  Navigator.pushNamed(context, '/');
                }else if(index == 11){ //Updates
                  Navigator.pushNamed(context, '/');
                }else if(index == 12){ //Short Flims
                  Navigator.pushNamed(context, '/');
                }else if(index == 13){ //Documentry
                  Navigator.pushNamed(context, '/');
                }else if(index == 14){ //Video Page
                  Navigator.pushNamed(context, '/Inbox');
                }
                else{
                  //ToDo
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(category: choices[index]),
                    ),
                  );
                }
              },
            );
          }
          )

    );
  }
}
class CategoryPage extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Category category;

  // In the constructor, require a Todo.
  CategoryPage({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    child = new Text("ToDo");
    //child = new Text(category.title.toString());

    /*if (category.id == 3) {

    }else {
      child = new Text("ToDo");
    }
    */

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: Colors.blue,
        //leading: Icon(category.icon),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: new Container(child: child),
      ),
    );
  }
}
class PlusVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("plus_video"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}


Widget userProfile() {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Column(
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid),
                  color: Colors.black,
                  shape: BoxShape.circle),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 18,
              width: 18,
              child: Icon(Icons.add, size: 10, color: Colors.white),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 42, 84, 1),
                  shape: BoxShape.circle),
            )
          ],

        )
      ],
    ),
  );
}

/*
class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("me"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
*/