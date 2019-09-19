import 'package:flutter/material.dart';
import 'package:tiktok_clone/resources/assets.dart';
import 'package:tiktok_clone/resources/dimen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Divider(
          height: 2,
          color: Colors.grey[700],
        ),
        Container(
          //height: 82,
          color: Colors.transparent,
          child: Padding(
              padding: EdgeInsets.only(top: 7),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(AppIcons.home),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Menu');
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(AppIcons.search),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Discover');
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 45.0,
                            height: 32.0,
                            child: Stack(children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 250, 45, 108),
                                      borderRadius: BorderRadius.circular(
                                          Dimen.createButtonBorder))),
                              Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 32, 211, 234),
                                      borderRadius: BorderRadius.circular(
                                          Dimen.createButtonBorder))),
                              Center(
                                  child: Container(
                                height: double.infinity,
                                width: 38,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimen.createButtonBorder)),
                                child: Icon(
                                  Icons.add,
                                  size: 20.0,
                                ),
                              )),
                            ]))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(AppIcons.messages),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Inbox');
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(AppIcons.profile),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Me');
                          },
                        ),
                      ],
                    ),
                  )

                ],

                )
          ),
        )
      ],
    );
  }
}
