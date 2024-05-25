import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';
import 'package:food_feed/main.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';


class Setup extends StatefulWidget {
  final bool logs;
  final String email;
  final String name;
  final String pic;

  Setup({@required this.logs, @required this.email, @required this.name, @required this.pic});

  @override
  _SetupState createState() => _SetupState(
    logs: this.logs,
    email: this.email,
    name: this.name,
    pic: this.pic
  );
}

class _SetupState extends State<Setup> {
  int count;
  var a;

  var list = [];

  final bool logs;
  final String email;
  final String name;
  final String pic;
  int j;

  _SetupState({@required this.logs, @required this.email, @required this.name, @required this.pic});

  @override
  void initState() {
    getCate().then((onValue){
      j = 11;
      setState(() {
        a = json.decode(onValue.body)['onValue'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Food|Feed', style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontWeight: FontWeight.w300),),
      ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/5938/food-salad-healthy-lunch.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ),
            Container(
              width: width,
              height: height,
              color: Color.fromRGBO(0, 0, 0, 0.7),
            ),
            Center(
              child: Container(
                color: Colors.white,
                width: width,
                height: height - 100,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom : 30.0),
                      child: Text("Follow you intrests", style: TextStyle(fontSize: 30)),
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
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ThemeButton(
        title: "Done",
        onPressed: (){
          savePrefs(list, email);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyHomePage(
            logs: true,
            name: name,
            email: email,
            pic: pic,
          )));
        },
      ),
    );
  }
}