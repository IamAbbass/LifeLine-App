import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:lifeline/bottom_nav_bar.dart';
import 'package:lifeline/resources/dimen.dart';
import 'package:lifeline/animations/spinner_animation.dart';
import 'package:lifeline/resources/assets.dart';
import 'package:lifeline/widgets/home/audio_spinner_icon.dart';
import 'package:video_player/video_player.dart';
import 'package:lifeline/classes/category.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lifeline/profile.dart';
import 'package:lifeline/me.dart';
import 'package:lifeline/discover.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppMain createState() => new MyAppMain();
}

class MyAppMain extends State<MyApp> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Video Header
  int _selectedVideoHeader = 1;
  void _onVideoHeader(int index) {
    setState(() {
      _selectedVideoHeader = index;
      print(_selectedVideoHeader);
    });
  }
  Widget _buildVideoHeader(int index, IconData icon, String tooltip) {
    return new Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: IconButton(
        icon: new Icon(icon),
        tooltip: tooltip,
        color: _selectedVideoHeader == index ? Colors.white : Colors.grey,
        onPressed: () {
          _onVideoHeader(index);
          Fluttertoast.showToast(
              msg: "You are watching '"+tooltip+"'",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0
          );
        },
      ),
    );
  }

  //Video Right Side
  int _likedVideo = 0;
  void _onVideoLike(int index) {
    setState(() {
      _likedVideo = index;
      print(_likedVideo);
    });
  }
  Widget _buildVideoRightSide(BuildContext context, String text, IconData icon, String tooltip) {

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
                      msg: "♥ Video Liked",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.red,
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
                print(text);
                //Navigator.pushNamed(context, '/TextCategory');
              },
          ),
          Padding(
            padding:
            EdgeInsets.only(
                top: Dimen.defaultTextSpacing, bottom: Dimen.defaultTextSpacing
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          )
        ],
      ),
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
        '/Inbox': (context) => Inbox(),
        '/Me': (context) => Me(),
        '/Profile': (context) => Profile(),
        '/TextCategory': (context) => TextCategory(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            PageView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, position) {
                  return Container(
                    color: Colors.black,
                    child: Stack(
                      children: <Widget>[
                        AppVideoPlayer(),
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
                                      "@mcofie",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4, bottom: 7),
                                    child: Text(
                                        "Lorem ipsum dolor sit amet, consectetur "
                                            "adipiscing elit, "
                                            "sed do eiusmod tempor.",
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
                                        "Lorem ipsum dolor sit amet ...",
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
                                    _buildVideoRightSide(context,"profile",AppIcons.profile,"Profile"),
                                    _buildVideoRightSide(context,"like",AppIcons.heart,"17.8k"),
                                    _buildVideoRightSide(context,"comment",AppIcons.chat_bubble,"130"),
                                    _buildVideoRightSide(context,"share",AppIcons.reply,"Share"),
                                    SpinnerAnimation(body: audioSpinner())
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                      ],
                    ),
                  );
                },
                itemCount: 10),
            BottomNavigation(),
            Container(
              margin: EdgeInsets.only(top: 40),
              height: Dimen.headerHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildVideoHeader(1,Icons.directions_run,"Following"),
                  Text("|",style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                  _buildVideoHeader(2,Icons.play_for_work,"For You"),
                  Text("|",style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                  _buildVideoHeader(3,Icons.location_on,"Near By"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text("All Categories"),
        backgroundColor: Colors.teal,
        //leading: Icon(Icons.person),
    ),

       */
      body: new GridView.builder(
          itemCount: choices.length,
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: new Card(
                elevation: 2.0,
                child: new Container(
                  color: Colors.black54,
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Text(""),
                      new Icon(
                        choices[index].icon,
                        size: 36,
                        color: Colors.teal,
                      ),
                      new Text(
                          choices[index].title,
                          style: TextStyle(fontSize: 18, color: Colors.white70),

                      ),
                      new Text(" "),
                      new Text(
                        choices[index].subtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey),

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryPage(category: choices[index]),
                                ),
                              );
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
                }else if(index == 9){ //Video Page
                  Navigator.pushNamed(context, '/TextCategory');
                }else{
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
        leading: Icon(category.icon),
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
class Inbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("inbox"),
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




class TextCategory extends StatefulWidget {
  @override
  TextCategoryState createState() => new TextCategoryState();
}
class TextCategoryState extends State<TextCategory>{
  int listItemCount = 3;

  void _showBottom(){
    showModalBottomSheet<void>(
        context: context,
        /*bottom sheet is like a drawer that pops off where you can put any
      controls you want, it is used typically for user notifications*/
        //builder lets your code generate the code
        builder: (BuildContext context){
          return new Container(
            padding: new EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('Please Login To Share', style: new TextStyle(color: Colors.white),),
                //new Button(context: Text('Please Login To Share')),
                //new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text('Close'),)
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Text Category"),
            backgroundColor: Colors.black,
            actions: <Widget>[
                // action button
                IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  _showBottom();
                },
            ),]
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          //pageSnapping: false,
          itemBuilder: (context, position) {
            return Container(
              padding: new EdgeInsets.all(32.0),
              child: new Center(
                child: new Text(
                    'Hello, world!',
                    style: TextStyle(fontSize: 36)
                ),
              ),
              //color: position % 2 == 0 ? Colors.black : Colors.white,
              color: Colors.black54,
            );
          },
        ),
      floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => TextWrite()));
            },
            tooltip: 'Increment',
            label: Text("Write"),
            icon: Icon(Icons.add),
            heroTag: "demoValue",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

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


class AppVideoPlayer extends StatefulWidget {
  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_5mb.mp4')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.initialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : Container(
        color: Colors.black,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
class menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
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