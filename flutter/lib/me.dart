import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';


class Me extends StatefulWidget {
  @override
  UserProfilePage createState() => UserProfilePage();
}




class UserProfilePage extends State<Me>{

  Map<String, dynamic> _profile;
  bool _loading = false;


  bool isLoggedIn;
  @override
  void initState() {
    isLoggedIn = false;
    FirebaseAuth.instance.currentUser().then((user) => user != null
        ? setState(() {
      isLoggedIn = true;
    })
        : null);
    super.initState();
    // new Future.delayed(const Duration(seconds: 2));

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() => isLoggedIn = user != null);
    });
  }



  /*
  @override
  initState(){
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
  }
  */
  


  @override
  Widget build(BuildContext context) {
    return AuthCondition();
  }
}


class AuthCondition extends StatefulWidget {
  @override
  AuthConditionState createState() => AuthConditionState();
}

class AuthConditionState extends State<AuthCondition>{


  final String _status = "@abbassified";
  final String _bio = "No videos to show!";
  final String _followers = "173";
  final String _posts = "24";
  final String _scores = "450";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pulse-black.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
  Widget _buildProfileImage(String photoUrl) {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(photoUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }
  Widget _buildFullName(String name) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      name,
      style: _nameTextStyle,
    );
  }
  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }
  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }
  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }
  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: authService.user,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  _buildCoverImage(screenSize),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: screenSize.height / 6.4),
                          _buildProfileImage(snapshot.data.photoUrl),
                          _buildFullName(snapshot.data.displayName),
                          _buildStatus(context),
                          _buildStatContainer(),
                          _buildBio(context),
                          _buildSeparator(screenSize),
                          SizedBox(height: 10.0),
                          SizedBox(height: 8.0),
                          //_buildButtons(),
                          RaisedButton(
                            shape: ContinuousRectangleBorder(),
                            child: Text("Log Out",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.red,
                            onPressed: () => authService.signOut(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );



          }else{
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  _buildCoverImage(screenSize),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: screenSize.height / 6.4),
                          _buildProfileImage("https://design.printexpress.co.uk/wp-content/uploads/2016/02/01-avatars.jpg"),
                          _buildFullName("Please login to Life Line"),
                          //_buildStatus(context),
                          //_buildStatContainer(),
                          //_buildBio(context),
                          //_buildSeparator(screenSize),
                          SizedBox(height: 10.0),
                          SizedBox(height: 8.0),
                          //_buildButtons(),
                          RaisedButton(
                            child: Text("Log In Now!",
                                style: TextStyle(color: Colors.white, fontSize: 24)),
                            padding: EdgeInsets.all(12),
                            elevation: 5,
                            color: Colors.blue,
                            onPressed: () => authService.googleSignIn(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      }
    );
  }
}


