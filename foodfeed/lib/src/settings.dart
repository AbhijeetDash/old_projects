import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';

class Setting extends StatefulWidget {
  final String email;
  final String url;
  Setting({@required this.email, @required this.url});
  @override
  _SettingState createState() => _SettingState(email: email, url: url);
}

class _SettingState extends State<Setting> {
  final String email;
  final String url;
  _SettingState({@required this.email, @required this.url});
  Widget alert = Container(width: 0,height: 0);
  bool error = false;
  String errMsg = "";
  int j = 0;
  var a;var list = [];
  var articles;
  int artiCount;
  bool reLogin = false;

  TextEditingController _urlPic;
  TextEditingController _name;

  @override
  void initState() {
    _urlPic = TextEditingController();
    _name = TextEditingController();
    getCate().then((onValue){
      j = 11;
      setState(() {
        a = json.decode(onValue.body)['onValue'];
      });
    });

    //get All Articles;
    getMyArticles(email).then((onValue){
      setState(() {
        artiCount = int.parse(json.decode(onValue.body)['length'].toString());
        articles = json.decode(onValue.body)['onValue'];
      });
    });

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if(error){
      error = false;
      reLogin = true;
      setState(() {
        alert = Container(
          alignment: Alignment.center,
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text(errMsg, style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,),
        );
      });
      Timer(Duration(seconds: 1), (){
        setState((){
          error = false;
          alert = Container(
            width: 0,
            height: 0,
          );
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Settings'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: Container(
              width: width*0.6,
              height: height,
              alignment: Alignment.center,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Update profile', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 20.0, left : 20.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100,
                          height:  100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: Container(
                        width: 350,
                        height: 80,
                        child: TextField(
                          controller: _urlPic,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            hintText: "new profile pic URL"
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: Container(
                        width: 350,
                        height: 80,
                        child: TextField(
                          controller: _name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            hintText: "enter your name"
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: ThemeButton(
                          title: "Update",
                          onPressed: (){
                            updateUser(_urlPic.text, _name.text, email);
                            setState(() {
                              error = true;
                              errMsg = "Profile updated\nPlease login again\nto see changes";
                              _urlPic.text = "";
                              _name.text = "";
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: Text('New Intrests', style: TextStyle(fontSize: 30)),
                    ),
                    Center(
                      child: Container(
                        height: height * .5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),            
                        child: Scrollbar(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: j,
                            itemBuilder: (context, i){
                              String title = "Follow";
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.20,
                                  height: width * 0.20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(a[i]['Pic'].toString()),
                                      fit: BoxFit.cover
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.20,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.7),
                                      borderRadius: BorderRadius.circular(30)
                                    ),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            a[i]['Category'].toString(),
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ThemeButton(
                                            title:title,
                                            onPressed: (){
                                              setState(() {
                                               title = "Following"; 
                                              });
                                              list.add(a[i]['Category'].toString());
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: ThemeButton(
                        title: "Update",
                        onPressed: (){
                          updateFollow(email, list);
                          print(list);
                          setState(() {
                            error = true;
                            errMsg = "Values Updated\nSuccessfully";
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left : 20.0, top : 10.0),
                      child: Text('Delete Articles', style: TextStyle(fontSize: 30)),
                    ),
                    Center(
                      child: Container(
                        height: height * .5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),            
                        child: Scrollbar(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: artiCount,
                            itemBuilder: (context, i){
                              String title = "Delete";
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.20,
                                  height: width * 0.20,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(articles[i]['Pic'].toString()),
                                      fit: BoxFit.cover
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.20,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.7),
                                      borderRadius: BorderRadius.circular(30)
                                    ),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            articles[i]['Title'].toString(),
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ThemeButton(
                                            title:title,
                                            onPressed: (){
                                              deleteArticle(articles[i]['Title'].toString(), email.toString()).then((onValue){
                                              });
                                              setState(() {
                                                error = true;
                                                errMsg = "Article ${articles[i]['Title'].toString()} Deleted\nSuccessfully"; 
                                              });
                                              initState();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            child: alert)
        ],
      ),
    );
  }
}