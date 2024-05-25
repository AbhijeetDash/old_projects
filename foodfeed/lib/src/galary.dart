import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';

class Galary extends StatefulWidget {
  @override
  _GalaryState createState() => _GalaryState();
}

class _GalaryState extends State<Galary> {

  var pictures;
  int len;

  @override
  void initState() {
    getGalary().then((onValue)=>{
      setState((){
        pictures = json.decode(onValue.body)['Pic'];
        len = int.parse(json.decode(onValue.body)['length'].toString());
      }),
      print(len)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallary'),
        elevation: 0.0,
        actions: <Widget>[
          ThemeButton(
            title: "Back",
            onPressed: (){
              Navigator.of(context).pop(true);
            },
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: Scrollbar(
          child: GridView.builder(
            itemCount: len,
            itemBuilder: (context, i){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(pictures[i]['Pic'].toString()),
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
              );
            }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0
            ),
          ),
        )
      ),
    );
  }
}