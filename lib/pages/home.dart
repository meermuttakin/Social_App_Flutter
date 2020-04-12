import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/activity_feed.dart';
import 'package:fluttershare/pages/create_account.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/pages/search.dart';
import 'package:fluttershare/pages/timeline.dart';
import 'package:fluttershare/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final userRef = Firestore.instance.collection('users');
final DateTime timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController _pageController;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  int pageIndex = 0;

//  _login() async{
//    try{
//      await _googleSignIn.signIn();
//      setState(() {
//        isAuth = true;
//      });
//    } catch (err){
//      print(err);
//    }
//  }

  createUserInfirestore() async {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await userRef.document(user.id).get();

    if(!doc.exists){
      final username = await Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => CreateAccount()
          ));
      userRef.document(user.id).setData({
        "id" : user.id,
        "username" : username,
        "photoUrl" : user.photoUrl,
        "email" : user.email,
        "displayName" : user.displayName,
        "bio" : "",
        "timestamp" : timestamp,
      });

      doc = await userRef.document(user.id).get();
    }

    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
  }

//  @override
//  void initState(){
//    super.initState();
//    _pageController = PageController();
//    _login();
//    //_logout();
//  }
  OnpaGechanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  OntaP(int pageIndex){
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  login() async {
    await googleSignIn.signIn();
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      isAuth = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    //_login();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      handleSignIn(account);
    }, onError: (err){
      print('User Sign In  : $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account){
      handleSignIn(account);
    }).catchError((err1){
      print('Error User Sign In 2: $err1');
    });
  }

  handleSignIn(GoogleSignInAccount account){
    if (account != null) {
      //print('User Sign In  : $account');
      createUserInfirestore();
      setState(() {
        isAuth = true;
      });
    }
    else {
      setState(() {
        isAuth = false;
      });
    }
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

   Scaffold buildAuthScreen(){
     return Scaffold(
       body: PageView(
         children: <Widget>[
           //Timeline(),
           RaisedButton(
             child: new Text('Logout'),
             onPressed: _logout,
           ),
           ActivityFeed(),
           Upload(),
           Search(),
           Profile(),
         ],
         controller: _pageController,
         onPageChanged: OnpaGechanged,
         physics: NeverScrollableScrollPhysics(),
       ),
       bottomNavigationBar: CupertinoTabBar(
         currentIndex: pageIndex,
         onTap: OntaP,
         activeColor: Theme.of(context).primaryColor,
         items: [
           BottomNavigationBarItem(icon: Icon(Icons.whatshot),),
           BottomNavigationBarItem(icon: Icon(Icons.notifications_active),),
           BottomNavigationBarItem(icon: Icon(Icons.photo_camera, size: 35.0,),),
           BottomNavigationBarItem(icon: Icon(Icons.search),),
           BottomNavigationBarItem(icon: Icon(Icons.account_circle),),
         ],
       ),
     );
  }

  Scaffold buildUnAuthScreen(){
    return Scaffold(
      body: new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        alignment: Alignment.center,

        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text('Sharing Caring',
              style: TextStyle(
                  fontFamily: "Signatra",
                  fontSize: 90,
                  color: Colors.white
              ),
            ),
            GestureDetector(
              onTap: login,
              child: new Container(
                width: 300.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/google_signin_button.png'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
