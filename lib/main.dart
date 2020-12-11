import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/variables.dart';
import 'webview.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List article;
  Map datas;
  Future getData() async {
    http.Response response;
    response = await http.get(textAPI);
    datas = json.decode(response.body);
    if (datas['status'] == 'ok') {
      setState(() {
        article = datas["articles"];
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'News',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              Text(
                'Today',
                style: TextStyle(color: Colors.blue, fontSize: 24),
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: article == null ? 0 : article.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FullNews(article[index]['url'])));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                            article[index]["urlToImage"] == null
                                ? nullImage
                                : article[index]["urlToImage"]),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        article[index]["title"],
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        article[index]["description"],
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
