import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:food_feed/src/article.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';

class Publish extends StatefulWidget {
  final String title;
  final String content;
  final String email;

  Publish({@required this.title, @required this.content, @required this.email});

  @override
  _PublishState createState() => _PublishState(title: title, content: content, email: email);
}

class _PublishState extends State<Publish> {
  final String title;
  final String content;
  final String email;
  int j; var a;
  var list = [];
  bool error = false;
  String errMsg = "";

  Widget alert = Container(
    width: 0,
    height: 0,
  );

  TextEditingController _url;


  _PublishState({@required this.title, @required this.content, @required this.email});

  @override
  void initState() {
    _url = TextEditingController();
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
  if(error){
      error != error;
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
      Timer(Duration(seconds: 3), (){
        setState(() {
          alert = Container(
            width: 0,
            height: 0,
          );
        });
      });
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Publish'),
        elevation: 0.0,
      ),
      body:Stack(
          children: <Widget>[ 
      Container(
        width: width,
        height: height,
        child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Text("Finishing up", style: TextStyle(color: Colors.black, fontSize: 30),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Container(
                      width: 400,
                      height: 100,
                      alignment: Alignment.centerLeft,
                      child: TextField(
                          controller: _url,
                          focusNode: FocusNode(),
                          decoration: InputDecoration(
                            hintText: "enter decoration Image url",
                          ),
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text("Select all Appropriate Category", style: TextStyle(color: Colors.black, fontSize: 30),),
                  ),
                  Center(
                    child: Container(
                      height: 250,
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
                                width: 250,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(a[i]['Pic'].toString()),
                                    fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 250,
                                  decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.7),
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
                                            if(list.isEmpty){
                                              list.add(a[i]['Category'].toString());
                                            } else {
                                              setState(() {
                                               error = true;
                                               errMsg = "Sorry, but articles can only\nhave one Category"; 
                                              });
                                            }
                                            print(list);
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
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: ThemeButton(
                      title: "Publish",
                      onPressed: (){
                        publish(title, content, _url.text, email, list);
                        setState(() {
                         error = true;
                         errMsg = "Article was Published"; 
                        });
                        Timer(Duration(seconds: 2), (){
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(MaterialPageRoute(builder: (context)=> Editor(email: "",)));
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
        ),
        Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: alert
        )
      ],
      ),
    );
  }
}