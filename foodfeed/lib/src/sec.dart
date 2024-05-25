import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:food_feed/main.dart';
import 'package:food_feed/src/info.dart';
import 'package:food_feed/utils/functions.dart';
import 'package:food_feed/utils/widgets.dart';



class Seq extends StatefulWidget {
  final String action;
  final bool error;
  final String errMsg;

  Seq({@required this.action, this.error, this.errMsg});

  @override
  _SeqState createState() => _SeqState(action: action, error : error, errMsg: errMsg);
}

class _SeqState extends State<Seq> with SingleTickerProviderStateMixin{

  final String action;
  TextEditingController _email;
  TextEditingController _password;
  String errorEmail = "";
  String errorPass = "";
  bool error = false;
  String errMsg = "";

  Widget alert = Container(
    width: 0,
    height: 0,
  );

  _SeqState({@required this.action, this.error, this.errMsg});

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    if(error == true){
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
      Timer(Duration(seconds: 2), (){
        setState(() {
          alert = Container(
            width: 0,
            height: 0,
          );
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  int validate(String data, String type){
    if(type == "email"){
      if(data.isNotEmpty){
        String a = data.substring(data.length - 10,data.length);
        if(a == "@gmail.com" || a == "@yahoo.com"){
          setState(() {
            errorEmail = "";
          });
          return 0;
        } else {
          setState(() {
           errorEmail = "Please check email";
          });
        }
      } else {
        setState(() {
          errorEmail = "Wait, WHAT!";
        });
      }
    }else if(type == "password"){
      if(data.isNotEmpty){
        setState(() {
          errorPass = "";
        });
        return 0;
      } else {
        setState(() {
          errorPass = "Are you out of your MIND!";
        });
      }
    }
    return 2;
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyHomePage(logs: false, pic: "",name: "",email: "",)));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1544510807-d0289d40b17c?ixlib=rb-1.2.1&auto=format&fit=crop&w=746&q=80'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          width: width,
          height: height,
          color: Color.fromRGBO(0, 0, 0, 0.7),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: width*0.4,
                  height: height*0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(action, style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.w800, fontSize: 40)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100, top: 12.0),
                        child: TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "enter your Email",
                            errorText: errorEmail
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100, top: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: _password,
                          obscureText: true,
                          focusNode: FocusNode(),
                          decoration: InputDecoration(
                            hintText: "enter your Password",
                            errorText: errorPass
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: ThemeButton(
                          title: action,
                          onPressed: (){
                            if(_email.text != null && _password.text != null){
                              int i = validate(_email.text,"email");
                              int k = validate(_password.text,"password");
                              if(i == 0 && k == 0){
                                if(action == "Login"){
                                  login(_email.text,_password.text).then((onValue){
                                    if(json.decode(onValue.body)['task'].toString() == "Successfull"){  
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context)=> MyHomePage(
                                            email: _email.text,
                                            name: json.decode(onValue.body)['Name'].toString(),
                                            pic: json.decode(onValue.body)['Profile'].toString(),
                                            logs: true,
                                          )
                                        )
                                      );
                                    } else if(json.decode(onValue.body)['task'].toString() == "No User") {
                                      setState(() {
                                        this.error = true;
                                        this.errMsg = "User doesn't exists!\nTry Signing up instead.."; 
                                        initState();
                                      });
                                    }
                                  });
                                } else if(action == "Join us") {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> InfoGetter(
                                    email: _email.text,
                                    password : _password.text
                                  )));
                                }
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                alert
              ],
            ),
          ),
        ),
      ),
    );
  }
}