import 'package:flutter/material.dart';

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
