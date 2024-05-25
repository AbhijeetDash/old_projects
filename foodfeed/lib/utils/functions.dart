import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> login(String email,String pass) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=login&email=${email}&pass=${pass}'));
  return a;
}

Future<bool> create(String email,String pass, String name, String url) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=create&email=${email}&pass=${pass}&name=${name}&pic=${url}'));
  if(json.decode(a.body)['task'].toString() == "Successfull"){
    return true;
  } 
  return false;
}

Future<http.Response> getCate() async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=categoryList'));
  return a;
}

Future<bool> savePrefs(var list, String email) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=addPrefs&list=${list}&email=${email}'));
  return true;
}

Future<bool> publish(String title, String content, String url, String email, var list) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=publish&title=${title}&content=${content}&url=${url}&email=${email}&tags=${list}'));
  return true;
}

Future<bool> draft(String title, String content, String email) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=draft&title=${title}&content=${content}&email=${email}'));
  return true;
}

Future<http.Response> getDraft(String email) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=getDraft&email=${email}'));
  return a;
}

Future<http.Response> getArticle(String email) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=getArticles&email=${email}'));
  return a;
}

Future<http.Response> getFollow(String email) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=getFollow&email=${email}'));
  return a;
}

Future<http.Response> getMyArticles(String email) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=getMyArticle&email=${email}'));
  return a;
}

Future<bool> updateFollow(String email, var list) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=updateFollow&email=${email}&tags=${list}'));
  return true;
}

Future<bool> unFollow(String email, String name) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=unFollow&email=${email}&name=${name}'));
  return true;
}

Future<bool> updateUser(String urlPic,String name, String email) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=updateUser&name=${name}&pic=${urlPic}&email=${email}'));
  return true;
}

Future<bool> deleteArticle(String email, String title) async {
  await http.get(Uri.encodeFull('http://localhost:3000/?task=deleteArticles&email=${email}&title=${title}'));
  return true;
}

Future<http.Response> search(String title) async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=Search&title=${title}'));
  return a;
}

Future<http.Response> getGalary() async {
  http.Response a = await http.get(Uri.encodeFull('http://localhost:3000/?task=galary'));
  return a;
}