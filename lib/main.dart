// ignore_for_file: prefer_const_constructors

import 'package:api_call/api_call.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Giphy>> giphy;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    giphy = getGifts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Api Calls in Flutter'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Giphy>>(
            future: giphy,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return ListView(
                return GridView.count(
                  crossAxisCount: 2,
                  // hasta aca espec.del grid
                  children: listGifs(snapshot.data),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    ));
  }

  //cargo el listView
  List<Widget> listGifs(data) {
    List<Widget> gifs = [];
    for (var gif in data) {
      gifs.add(Card(
        child: Column(children: [
          Expanded(
              child: Image.network(
            gif.url,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(gif.name),
          )
        ]),
      ));
    }
    return gifs;
  }
}
