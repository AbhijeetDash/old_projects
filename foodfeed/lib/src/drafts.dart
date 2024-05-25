import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:food_feed/src/article.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';

class Drafts extends StatefulWidget {
  final String email;
  
  Drafts({@required this.email});

  @override
  _DraftsState createState() => _DraftsState(email: email);
}

class _DraftsState extends State<Drafts> {
  final String email;
  var a;
  int j;

  _DraftsState({@required this.email});

  @override
  void initState() {
    getDraft(email).then((onValue){
      j = onValue.body[0].length;
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
        title: Text('Drafts'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width : width,
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
              width: width * 0.6,
              height: height * 0.6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: j>0?Scrollbar(
                child: ListView.builder(
                  itemCount: j,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(a[i]['Title'].toString(), style: TextStyle(fontSize: 20)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(a[i]['Content'].toString(), style: TextStyle(fontSize: 13)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: ThemeButton(
                                title: "Edit",
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Editor(email: email.toString(),title: a[i]['Title'].toString(), content: a[i]['Content'].toString(),)));
                                
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ):Padding(
                padding: EdgeInsets.all(10),
                child: Text("NO DRAFTS AVAILABLE", style: TextStyle(fontSize: 30),),
              ),
            ),
          )
        ],
      ),
    );
  }
}