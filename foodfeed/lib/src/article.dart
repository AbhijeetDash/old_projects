import 'dart:html';
import 'package:flutter_web/material.dart';
import 'package:food_feed/src/publish.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';

class Editor extends StatefulWidget {
  final String email;
  final String title;
  final String content;

  Editor({@required this.email, this.title, this.content});

  @override
  _EditorState createState() => _EditorState(email: email, title: title, content: content);
}

class _EditorState extends State<Editor> {

  TextEditingController _title;
  TextEditingController _content;
  final String email;
  String title;
  String content;

  _EditorState({@required this.email, this.title, this.content});

  @override
  void initState() {
    _title = TextEditingController();
    _content = TextEditingController();
    if(title != "" && content != ""){
      setState(() {
        _title.text = title;
        _content.text = content;
      });
    }
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
        actions: <Widget>[
          ThemeButton(
            title: "Back",
            onPressed: (){
              Navigator.of(context).pop(true);
            },
          ),
          ThemeButton(
            title: "Publish",
            onPressed: (){
              String title = _title.text;
              String content = _content.text;
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Publish(
                title: title,
                content: content,
                email: email
              )));
            },
          ),
          ThemeButton(
            title: "Draft",
            onPressed: (){
              draft(_title.text, _content.text, this.email);
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
      body : Container(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(left:width*0.1, right: width*0.1, top: 20),
          child: ListView(    
              children: <Widget>[
                TextField(
                  controller: _title,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 30),
                    hintText: "Title"
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 40),
                  maxLength: 40,  
                ),
                TextField(
                  controller: _content,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                    hintText: "Type you Recipie here"
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  maxLines: 100,
                )
              ],
            ),
          )
        ),
    );
  }
}