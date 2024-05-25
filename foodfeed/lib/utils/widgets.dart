import 'package:flutter_web/material.dart';
import 'package:food_feed/src/read.dart';

class ThemeButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String title;
  ThemeButton({@required this.onPressed, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 6.0, top: 8.0, bottom: 8.0),
      child: RawMaterialButton(
        fillColor: Colors.orangeAccent,
        splashColor: Colors.deepOrange,
        shape: StadiumBorder(),
        padding: EdgeInsets.all(2.0),
        onPressed: onPressed,
        child: Text(title, style: TextStyle(color: Colors.white,  )),
      ),
    );   
  }
}

class TopThumb extends StatelessWidget {
  final String url;
  final String topic;

  TopThumb({@required this.url, @required this.topic});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
                ),
              ),
            ),
            Text(topic, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100, fontSize: 10, decoration: TextDecoration.none,  ),)
          ],
        ),
      ),
    );
  }
}

class Article extends StatelessWidget {

  final String url;
  final String heading;
  final String auther;
  final String sampletext;

  Article({@required this.url, @required this.heading, @required this.auther, @required this.sampletext});
  
  @override
  Widget build(BuildContext context) {
    Color likeColor = Colors.white;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top : 20.0),
      child: Container(
        height: height*0.5,
        width: width,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover
                    )
                  ),
                  width: width*0.3,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
                Container(
                  width: width*0.4,
                  color: Colors.grey[800],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Text(heading, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100 , decoration: TextDecoration.none,  )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text(auther, style: TextStyle(color: Colors.grey[200], decoration: TextDecoration.none, fontSize: 12,fontWeight: FontWeight.w100),),
                      ),
                      Container(
                        height: height*0.2,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(sampletext, 
                            style: TextStyle(
                              color: Colors.white, 
                              decoration: TextDecoration.none, 
                              fontSize: 16,
                              fontWeight: FontWeight.w100
                            )
                          ),
                        )
                      ),  
                      Padding(
                        padding: const EdgeInsets.only(top:16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.star, color: likeColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.save, color: likeColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left : 8.0),
                  child: Container(
                    height: height*0.5,
                    width: width*0.2,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]
                    ),
                    child: Column(
                      children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('More by Chefman', style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 24, fontWeight: FontWeight.w100, ),),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Ice-Creams', style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 18, fontWeight: FontWeight.w100, ),),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Fast Food', style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 18, fontWeight: FontWeight.w100, ),),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Piper Pizza', style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 18, fontWeight: FontWeight.w100, ),),
                         ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyListItem extends StatelessWidget {

  final String tag;
  final String title;
  final String content;
  final String writter;
  final String url;
  final String pic;
  final String email;

  MyListItem({@required this.email, @required this.tag, @required this.title, @required this.content, @required this.writter, @required this.url, @required this.pic});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 1/1.5,
        child: Padding(
        padding: EdgeInsets.all(10),
          child: FlatButton(
            onPressed: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reader(
                 title: title,
                 content: content,
                 writter: writter,
                 url: url,
                 pic: pic,
                 tag: tag,
                 email: email,
               )));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        url
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 450,
                      height: ((height-10)*0.35),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200),
                        )
                      ),
                      child: Text(title, style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.white),),
                    ),
                    Container(
                      height: ((height-10)*0.20),
                    ),
                    Container(
                      height: ((height-35)*0.45),
                      width: 450,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(150),
                          topRight: Radius.circular(150),
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(content.substring(0, 100), style: TextStyle(color:Colors.white),textAlign: TextAlign.center,)
                      )
                    ),
                  ],
                )
              ]
            ),
          ),
        
      ),
    );
  }
}