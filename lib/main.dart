import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Model.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Model? model;
  List<Articles>? articles;
  getDataFromNewsApi() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c70c83853350402ebcf1ab267fd04e69"));
    model = Model.fromJson(jsonDecode(response.body));
    setState(() {
      articles = model!.articles;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text.rich(TextSpan(
            text: "News",
            style: TextStyle(color: Colors.white, fontSize: 21),
            children: [
              TextSpan(
                text: "App",
                style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              )
            ])),
      ),
      body: articles == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebPage(
                                        url: articles![i].url,
                                      )));
                        },
                        child: articles![i].urlToImage == null
                            ? Container(
                                width: 300,
                                height: 50,
                                margin: EdgeInsets.symmetric(vertical: 15),
                                color: Colors.green.withOpacity(0.1),
                                child: Center(
                                    child: Text("Error to loading image")))
                            : Card(
                                child: Image.network(
                                    articles![i].urlToImage.toString()),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                          text: "Title :",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                          children: [
                            TextSpan(
                              text: articles![i].title,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            )
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                          text: "Content :",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                          children: [
                            TextSpan(
                              text: articles![i].content,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            )
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                          text: "Description :",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                          children: [
                            TextSpan(
                              text: articles![i].description,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            )
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}

//For adding webview first add webview plugin
//also make screen for web view

class WebPage extends StatelessWidget {
  String? url;
  WebPage({this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
      ),
    );
  }
}
