import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifeline/bottom_nav_bar.dart';
import 'package:lifeline/resources/dimen.dart';
import 'package:lifeline/animations/spinner_animation.dart';
import 'package:lifeline/resources/assets.dart';
import 'package:lifeline/widgets/home/audio_spinner_icon.dart';
import 'package:lifeline/resources/dimen.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      initialRoute: '/',
      routes: {
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(AppIcons.profile,
                                              color: Colors.white,
                                              size: 35,),
                                            onTap: (){
                                              Navigator.pushNamed(context, '/Profile');
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimen.defaultTextSpacing, bottom: Dimen.defaultTextSpacing),
                                            child: Text(
                                              "Profile",
                                              style: TextStyle(fontSize: 10, color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(AppIcons.heart,
                                              color: Colors.white,
                                              size: 35,),
                                            onTap: (){
                                              //Navigator.pushNamed(context, '/TextCategory');
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimen.defaultTextSpacing, bottom: Dimen.defaultTextSpacing),
                                            child: Text(
                                              "17.8k",
                                              style: TextStyle(fontSize: 10, color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(AppIcons.chat_bubble,
                                              color: Colors.white,
                                              size: 35,),
                                            onTap: (){
                                              Navigator.pushNamed(context, '/TextCategory');
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimen.defaultTextSpacing, bottom: Dimen.defaultTextSpacing),
                                            child: Text(
                                              "130",
                                              style: TextStyle(fontSize: 10, color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(AppIcons.reply,
                                              color: Colors.white,
                                              size: 35,),
                                            onTap: (){
                                              Navigator.pushNamed(context, '/TextCategory');
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimen.defaultTextSpacing, bottom: Dimen.defaultTextSpacing),
                                            child: Text(
                                              "Share",
                                              style: TextStyle(fontSize: 10, color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SpinnerAnimation(
                                        body: audioSpinner())
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

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: IconButton(
                      icon: new Icon(Icons.directions_run),
                      tooltip: "Following",
                      color: Colors.teal,
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Following Videos'),
                              duration: Duration(seconds: 1),
                            ));
                      },
                    ),
                  ),
                  Text("|",
                      style: TextStyle(
                          fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: IconButton(
                      icon: new Icon(Icons.play_for_work),
                      tooltip: "For You",
                      color: Colors.grey,
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('For You Videos'),
                              duration: Duration(seconds: 1),
                            ));
                      },
                    ),

                    /*
          child: Text(AppStrings.forYouString,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
                  */
                  ),
                  Text("|",
                      style: TextStyle(
                          fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: IconButton(
                      icon: new Icon(Icons.location_on),
                      tooltip: "Near By",
                      color: Colors.grey,
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Near By Videos'),
                              duration: Duration(seconds: 1),
                            ));
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  const Category({this.id,this.title, this.icon, this.subtitle});
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  String toString() => title;
}
const List<Category> choices = const <Category>[
  const Category(id:1, title: 'Home', icon: Icons.home, subtitle: "Mix Category",),
  const Category(id:2, title: 'Mugic', icon: Icons.music_note, subtitle: "Tik Tok Category",),
  const Category(id:3, title: 'Radio', icon: Icons.radio, subtitle: "Listen Live Radio",),
  const Category(id:4, title: 'Program', icon: Icons.live_tv, subtitle: "Watch Programs",),
  const Category(id:5, title: 'Picture', icon: Icons.image, subtitle: "Instagram Category",),
  const Category(id:6, title: 'Vlogs', icon: Icons.camera_front, subtitle: "Watch Vlogs",),
  const Category(id:7, title: 'Blogs', icon: Icons.format_quote, subtitle: "Read Blogs",),
  const Category(id:8, title: 'Stories', icon: Icons.slow_motion_video, subtitle: "Friend's Stories",),
  const Category(id:9, title: 'Memes', icon: Icons.accessibility, subtitle: "Funny Videos",),
  const Category(id:10, title: 'Text', icon: Icons.format_shapes, subtitle: "Twitter Category",),
  const Category(id:11, title: 'Cartoon', icon: Icons.child_care, subtitle: "Kid's Category",),
  const Category(id:12, title: 'Updates', icon: Icons.voice_chat, subtitle: "Live",),
  const Category(id:13, title: 'Short Flim', icon: Icons.movie_filter, subtitle: "Short Stories",),
  const Category(id:14, title: 'Documentry', icon: Icons.local_movies, subtitle: "Information",),
  const Category(id:15, title: 'Chit Chat', icon: Icons.chat, subtitle: "Chatting Category",),
  const Category(id:15, title: 'Review', icon: Icons.rate_review, subtitle: "Review Category",),
];

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


                //yahan
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
class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover"),
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
class Profile extends StatelessWidget {
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

