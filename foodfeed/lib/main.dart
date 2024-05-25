import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:food_feed/src/article.dart';
import 'package:food_feed/src/drafts.dart';
import 'package:food_feed/src/galary.dart';
import 'package:food_feed/src/sec.dart';
import 'package:food_feed/src/settings.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';

import 'src/sec.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food|Feed',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryTextTheme: TextTheme(title: TextStyle( )),
      ),
      home: MyHomePage(title: 'Food|Feed', logs: false, pic:"",name:"",email:""),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.logs, @required this.email, @required this.name, @required this.pic}) : super(key: key);
  final String title;
  final bool logs;
  final String name, email, pic;
  @override
  State<StatefulWidget> createState() {
    return MyPageState(logs: this.logs, name: this.name, email: this.email, pic: this.pic);
  }
}

class MyPageState extends State<MyHomePage> with TickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController controller;
  Animation animation; 
  bool searching = false;
  var articles;
  final String name, email, pic;
  int artiCount = 0;
  var follows;
  int followCount = 0;
  var a; int j;
  TextEditingController searchString;
  bool err = false;
  String errMsg = "";

  Widget alert = Container(
    width: 0,
    height: 0,
  );
  Widget searchResult = Container(
    width: 0,
    height: 0,
  );

  bool logs;
  MyPageState({@required this.logs, @required this.email, @required this.name, @required this.pic});

  @override
  void initState() {
    searchString = TextEditingController();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    scrollController = ScrollController();
    Timer(Duration(seconds: 1), () {
      controller.forward();
    });

    //get all the Articles.
    if(logs == true){
      getFollow(email).then((onValue){
        follows = json.decode(onValue.body);
        followCount = follows.length;
      });
      getArticle(email).then((onValue){
        setState(() {
          articles = json.decode(onValue.body)['article'];
          artiCount = int.parse(json.decode(onValue.body)['length'].toString()) + 2;
        });
      });
      
    } else {
      getArticle("").then((onValue){
        setState(() {
          articles = json.decode(onValue.body)['article'];
          artiCount = int.parse(articles[0]['length'].toString()) + 2;
        });
      });
      getCate().then((onValue){
        j = 11;
        setState(() {
          a = json.decode(onValue.body)['onValue'];
        });
      });
    }
    super.initState();
  }

  void getResult(String title) {
    if(title == ""){
      setState(() {
       err = true;
       errMsg = "Can't search nothing!\nStop kidding.. :)"; 
      });
      Timer(Duration(seconds: 4),(){
        setState(() {
          err = false;
          errMsg = "";
        });
      });
    } else {
      setState(() {
        searching = true; 
      });
      search(title).then((onValue){
        if(json.decode(onValue.body)['length'] == 0){
          setState(() {
            err = true;
            errMsg = "Article not found"; 
          });
          Timer(Duration(seconds: 2),(){
            setState(() {
              err = false;
              errMsg = "";
            });
          });
        } else if(json.decode(onValue.body)['length'] >= 1){
          int countArti = int.parse(json.decode(onValue.body)['length'].toString())+2;
          var artic = json.decode(onValue.body)['data'];
          setState(() {
            searchResult = Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              color: Colors.white,
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: countArti,
                  itemBuilder: (context, i){
                    if(i == 0){
                      return Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Text('Dishes to Explore', style:TextStyle(color: Colors.black, fontSize: 30, fontStyle: FontStyle.italic), textAlign: TextAlign.center,)
                      );
                    } else if(i == countArti - 1){
                      return Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hope you found what\nyou were looking for..", style: TextStyle(color: Colors.black, fontSize: 30, fontStyle: FontStyle.italic,),textAlign: TextAlign.center,),
                            ),
                            ThemeButton(
                              title: "Done",
                              onPressed: (){
                                setState(() {
                                  searchResult = Container(
                                    width: 0,
                                    height: 0,
                                  ); 
                                });
                                initState();
                              },
                            )
                          ],
                        )
                      );
                    }else {
                      return MyListItem(
                        title: artic[i-1]['title'].toString(),
                        url : artic[i-1]['url'].toString(),
                        writter: artic[i-1]['auth'].toString(),
                        pic : artic[i-1]['pic'].toString(),
                        content: artic[i-1]['content'].toString(),
                        tag: artic[i-1]['tags'].toString(),
                        email: email,
                      );
                    }
                  },
                ),
              ),
            );
          });
          Timer(Duration(seconds: 10), (){
            setState(() {
             searchResult = Container(
               width: 0,
               height: 0,
             );
            });
          });
        }
      });
      Timer(Duration(seconds: 4),(){
        setState(() {
          searching = false;
        });
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(err){
      err != err;
      setState(() {
        alert = Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Text(errMsg, style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,),
          ),
        );
      });
      Timer(Duration(seconds: 2), (){
        setState(() {
          alert = Container(
            width: 0,
            height: 0,
          );
        });
      });
    }

    Widget logup;
    if(logs == false){
      setState(() {
        logup = Container(
          child: Row(
            children: <Widget>[
              ThemeButton(
                title: "Login",
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>Seq(action: "Login", error: false)));
                }
              ),
              ThemeButton(
                title: "Sign-up",
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Seq(action: "Join us", error: false)));
            }),
            ],
          ),
        );
      });
    } else if(logs == true){
      setState(() {
        logup = Container(
          width: 200,
          alignment: Alignment.topCenter,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 40.0),
            leading: Container(
              alignment: Alignment.topCenter,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(pic),
                  fit: BoxFit.cover
                )
              ),
            ),
            title: Text(name, style: TextStyle(color: Colors.white, fontSize: 16)),
            subtitle: Text("Signed in", style: TextStyle(color: Colors.white, fontSize: 10)),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Setting(email: email, url: pic,)));
            },
          ),
        );
      });
    }

    return Scaffold(
      drawer: Drawer(
      elevation: 16.0,
      child:
          Scrollbar(
            child: ListView(
              children: <Widget>[
                Container(
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=353&q=80'),
                        fit: BoxFit.cover
                      )
                    ),
                  child: Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                    child: Center(
                      child: ListTile(
                        title: CircleAvatar(
                          radius: 50,
                          child: Text('Food|Feed',style:TextStyle(fontSize: 50)),
                        ),
                      ),
                    )
                  ),
                ),
                ListTile(
                  leading: Icon( Icons.settings,size: 20),
                  title: Text('My Account',style: TextStyle(fontSize: 15)),
                  subtitle: Text('View and edit your details!',style: TextStyle(fontSize: 12)),
                  onTap: (){
                    if(logs){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Setting(email: email,url: pic,)));               
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
                        Seq(
                          action: "Login",
                          errMsg: "Please login!\nto access account settings..",
                          error: true,
                        )
                      ));
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.low_priority,size: 20),
                  title: Text('Drafts',style: TextStyle(fontSize: 15)),
                  subtitle: Text("Complete your reciepies",style: TextStyle(fontSize: 12)),
                  onTap: () {
                    if(logs){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Drafts(email: this.email)));               
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.new_releases,size: 20),
                  title: Text('New Recepie',style: TextStyle(fontSize: 15)),
                  subtitle: Text('Got new ideas? How about writing!',style: TextStyle(fontSize: 12)),
                  onTap: () {
                    if(logs){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Editor(email: email)));               
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
                        Seq(
                          action: "Login",
                          errMsg: "Please login!\nBefore writing a recipe..",
                          error: true,
                        )
                      ));
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ),
                ThemeButton(
                  title: "Logout!",
                  onPressed: (){
                    setState(() {
                      logs = false;
                    });
                    initState();
                  },
                ),
                Container(
                  height: 20,
                  child: Center(
                    child: Text('Privacy policies || Terms of use',style: TextStyle(fontSize: 20,  ))
                  )
                ),
              ],
            ),
          ),
    ),
    body: Stack(
      children: <Widget>[
        Container(
          width: width,
          color: Colors.grey[800],
          child: Container(
            color: Colors.grey[800],
            width: width * 0.7,
            child: Scrollbar(
              child: Container(
                width: width * 0.3,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.deepOrange,
                      title: Row(
                        children: <Widget>[
                          Text("Food|Feed", style: TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                      elevation: 0.0,
                      actions: <Widget>[
                        ThemeButton(
                          title: "Galary", 
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Galary()));
                          }
                        ),
                        logup,                      
                      ],
                    ),
                    Container(
                      color: Colors.deepOrange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.deepOrange,
                            width: width * 0.6,
                            height: 100,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: logs?followCount:j,
                                itemBuilder: (context, i){
                                  return logs?TopThumb(
                                    url:follows[i]['Pic'].toString(),
                                    topic: follows[i]['Category'].toString(),
                                  ):TopThumb(
                                    url:a[i]['Pic'].toString(),
                                    topic: a[i]['Category'].toString(),
                                  );
                                },
                              )                        
                            ),
                          ),
                          Container(
                            height: 100,
                            color: Colors.deepOrange,
                            width: width * 0.4,
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right:20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 300,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      textInputAction: TextInputAction.done,
                                      controller: searchString,
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(),
                                        fillColor: Colors.grey[200],
                                        filled: true
                                      ),
                                      style: TextStyle(
                                          fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: RawMaterialButton(
                                      constraints: BoxConstraints(
                                          minWidth: 50,
                                          maxWidth: 50,
                                          maxHeight: 50,
                                          minHeight: 50),
                                      shape: CircleBorder(),
                                      onPressed: () {
                                        setState(() {
                                          scrollController.animateTo(height+50, curve:Curves.linear, duration: Duration(milliseconds: 500));
                                        });
                                        getResult(searchString.text);
                                      },
                                      child: Icon(Icons.search,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: height - 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/1565982/pexels-photo-1565982.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        width: width,
                        height: height - 100,
                        alignment: Alignment.centerLeft,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        child: Container(
                          height: height * 0.4,
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeTransition(
                                opacity: animation,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: width * 0.3),
                                  child: Image(
                                      image: AssetImage('fl.png'),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              FadeTransition(
                                opacity: animation,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 00, right: 20),
                                  child: Container(
                                    width: width * 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('- Spices -', style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("We must have a pie. Stress cannot exist in the presence of a pie. Part of the secret of success in life is to eat what you like and let the food fight it out inside.", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white), textAlign: TextAlign.center,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height,
                      color: Colors.grey[200],
                      child: Stack(
                        children: <Widget>[
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: artiCount,
                            itemBuilder: (context,i){  
                              if(i == 0){
                                return Container(
                                  width: width*0.4,
                                  height: height,
                                  alignment: Alignment.center,
                                  child: Text('Dishes to Explore', style:TextStyle(color: Colors.black, fontSize: 30, fontStyle: FontStyle.italic), textAlign: TextAlign.center,)
                                );
                              } else if(i == artiCount-1){
                                return Container(
                                  width: width*0.4,
                                  height: height,
                                  alignment: Alignment.center,
                                  child: Text("You've read everythin?\nTry cooking something!", style:TextStyle(color: Colors.black, fontSize: 30, fontStyle: FontStyle.italic), textAlign: TextAlign.center,)
                                );
                              } else {
                                return MyListItem(
                                  title: articles[i-1]['title'].toString(),
                                  url : articles[i-1]['url'].toString(),
                                  writter: articles[i-1]['auth'].toString(),
                                  pic : articles[i-1]['pic'].toString(),
                                  content: articles[i-1]['content'].toString(),
															    tag: articles[i-1]['tags'].toString(),
														  	  email: email,
                                );
                              }
                            }
                          ),
                          searching?Container(
                            width: width,
                            height: height,
                            alignment: Alignment.center,
                            color: Colors.grey[800],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                                Text("Loding Search Results", style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ):Container(),
                          searchResult
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height-300,
                        width: width,
                        color: Colors.grey[900],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: (width/100)*30,
                              height: height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 50.0, left: 30),
                                    child: Text('Food & Taste', style: TextStyle(fontSize: 30, color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:30.0),
                                    child: Text("Lorem Ipsum is simply dummy\ntext of the printing and typesetting industry\nLorem Ipsum has been the industry's standard\ndummy text ever since the 1500s", style: TextStyle(color: Colors.white),),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: (width/100)*30,
                              height: height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 50.0, left: 30),
                                    child: Text('Other Links', style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.underline),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:30.0, bottom: 10,),
                                    child: Text("About", style: TextStyle(color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:30.0, bottom: 10,),
                                    child: Text("Blog", style: TextStyle(color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:30.0, bottom: 10,),
                                    child: Text("Gallary", style: TextStyle(color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:30.0, bottom: 10,),
                                    child: Text("Privacy Policies", style: TextStyle(color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:30.0, bottom: 10,),
                                    child: Text("Terms & Conditions", style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (width/100)*30,
                              height: height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 30, bottom: 20),
                                    child: Text('Recieve newsletter', style: TextStyle(fontSize: 25, color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0,right: 100),
                                    child: Container(
                                            width: 300,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              textInputAction: TextInputAction.done,
                                              decoration: InputDecoration(
                                                hintText: "Recieve news-letters",
                                                hintStyle: TextStyle(),
                                                fillColor: Colors.grey[200],
                                                filled: true
                                              ),
                                              style: TextStyle(
                                                  fontSize: 14,
                                              ),
                                            ),
                                          ),
                                  ),
                                  ThemeButton(
                                    onPressed: (){},
                                    title: "Subscribe",
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: (width/100)*10,
                              height: height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage('https://i.pinimg.com/originals/41/28/2b/41282b58cf85ddaf5d28df96ed91de98.png'),
                                          fit: BoxFit.contain
                                        )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage('https://png.pngtree.com/element_our/sm/20180626/sm_5b321ca31d522.png'),
                                          fit: BoxFit.contain
                                        )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage('https://www.freeiconspng.com/uploads/logo-twitter-circle-png-transparent-image-1.png'),
                                          fit: BoxFit.fill
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    ],
                  )
                )
              )
            )
          ),
          alert
      ],
    ),
      floatingActionButton: ThemeButton(
        title: "Reload",
        onPressed: (){
          initState();
        },
      ),
    );
  }
}