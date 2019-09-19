import 'package:flutter/material.dart';
import 'package:tiktok_clone/bottom_nav_bar.dart';
import 'package:tiktok_clone/pages/home_page.dart';
import 'package:tiktok_clone/widgets/home/home_header.dart';

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
      },

      debugShowCheckedModeBanner: false,
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
  const Category({this.title, this.icon, this.subtitle});
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  String toString() => title;
}
const List<Category> choices = const <Category>[
  const Category(title: 'Home', icon: Icons.home, subtitle: "Mix Category",),
  const Category(title: 'Mugic', icon: Icons.music_note, subtitle: "",),
  const Category(title: 'Radio', icon: Icons.radio, subtitle: "",),
  const Category(title: 'Program', icon: Icons.live_tv, subtitle: "",),
  const Category(title: 'Picture', icon: Icons.image, subtitle: "",),
  const Category(title: 'Vlogs', icon: Icons.camera_front, subtitle: "",),
  const Category(title: 'Blogs', icon: Icons.format_quote, subtitle: "",),
  const Category(title: 'Stories', icon: Icons.slow_motion_video, subtitle: "",),
  const Category(title: 'Memes', icon: Icons.accessibility, subtitle: "",),
  const Category(title: 'Text', icon: Icons.format_shapes, subtitle: "",),
  const Category(title: 'Cartoon', icon: Icons.child_care, subtitle: "",),
  const Category(title: 'Updates', icon: Icons.voice_chat, subtitle: "",),
  const Category(title: 'Short Flim', icon: Icons.movie_filter, subtitle: "",),
  const Category(title: 'Documentry', icon: Icons.local_movies, subtitle: "",),
  const Category(title: 'Chit Chat', icon: Icons.chat, subtitle: "",),
];

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Life Line Categories"),
        //leading: Icon(Icons.person),
    ),

      body: ListView.builder(
        itemCount: choices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(choices[index].title),
            leading: Icon(choices[index].icon),
            subtitle: Text(choices[index].subtitle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: choices[index]),
                ),
              );
            },
          );
        },
      ),


    );
  }
}
class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Category todo;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.subtitle),
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

