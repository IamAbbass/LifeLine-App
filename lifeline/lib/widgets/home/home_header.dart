import 'package:flutter/material.dart';
import 'package:lifeline/resources/dimen.dart';
import 'package:lifeline/resources/strings.dart';

Widget homeHeader() {
  return Container(
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
            color: Colors.white,
            onPressed: () {
              //Navigator.pushNamed(context, '/Menu');
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
            color: Colors.teal,
            onPressed: () {
              //Navigator.pushNamed(context, '/Menu');
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
            tooltip: "For You",
            color: Colors.white,
            onPressed: () {


            },
          ),
        ),

      ],
    ),
  );
}
