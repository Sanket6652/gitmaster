import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:gitmaster/card/commands_card.dart';
import 'package:gitmaster/screen/lesson_screen.dart';
import 'package:gitmaster/scrolleventnotifier.dart';
import 'package:provider/provider.dart';

import '../card/learn_card.dart';

class homescreen extends StatefulWidget {
  homescreen({Key? key}) : super(key: key);
  @override
  State<homescreen> createState() => _homescreen();
}

// ignore: camel_case_types
class _homescreen extends State<homescreen> {
  List _items = [];
  List _lessomnList = [];
  String searchText = '';

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/git_commands.json');
    final data = await json.decode(response);

    setState(() {
      _items = data["gitCommands"];
    });
  }

  Future<Void> secondjson() async {
    final String lessonresponse =
        await rootBundle.rootBundle.loadString('assets/git_lessons.json');
    final responsedata = await json.decode(lessonresponse);
    //print(responsedata);
    setState(() {
      _lessomnList = responsedata["gitLessons"];
    });
    throw Exception('Failed to fetch the second JSON file');
  }

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    readJson();
    secondjson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Git Master"),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Image.asset("assets/icon/GitIcon.png"),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("setting"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: Expanded(
                  child: Column(
                    children: [
                  const TabBar(
                      indicatorColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: "Learn",
                        ),
                        Tab(
                          text: "Reference",
                        )
                      ]
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 600,
                    child: TabBarView(children: <Widget>[
                      ChangeNotifierProvider.value(
                          value: ScrollEventNotifier(false),
                          child: Builder(
                            builder: (BuildContext context) {
                              var scrollListener =
                                  Provider.of<ScrollEventNotifier>(context);
                              return NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification is ScrollStartNotification) {
                                    scrollListener.isScrolling = true;
                                  } else if (notification
                                      is ScrollEndNotification) {
                                    scrollListener.isScrolling = false;
                                  }
                                  return true;
                                },
                                child: ListView.builder(
                                  itemCount: _lessomnList.length,
                                  itemBuilder: (context, index) {
                                    final lesson = _lessomnList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonDetailScreen(
                                                      lesson: lesson,
                                                    )));
                                      },
                                      child: learnCard(
                                        lessonname: _lessomnList[index]
                                                ["LessonTitle"]
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )),
                      ChangeNotifierProvider.value(
                        value: ScrollEventNotifier(false),
                        child: Builder(
                          builder: (BuildContext context) {
                            var scrollListener =
                                Provider.of<ScrollEventNotifier>(context);
                            return NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollStartNotification) {
                                  scrollListener.isScrolling = true;
                                } else if (notification
                                    is ScrollEndNotification) {
                                  scrollListener.isScrolling = false;
                                }
                                return true;
                              },
                              child: ListView.builder(
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return commandCard(
                                    command:
                                        _items[index]["command"].toString(),
                                    name: _items[index]["name"].toString(),
                                    discription: _items[index]["description"],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ]),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
