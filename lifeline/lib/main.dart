import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifeline/bottom_nav_bar.dart';
import 'package:lifeline/pages/home_page.dart';
import 'package:lifeline/widgets/home/home_header.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        '/TextCategory': (context) => TextCategory(),
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            HomeScreen(),
            BottomNavigation(),
            homeHeader(),
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

