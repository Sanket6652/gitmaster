

import 'package:flutter/material.dart';
import 'package:gitmaster/scrolleventnotifier.dart';
import 'package:provider/provider.dart';

class commandCard extends StatelessWidget {
  commandCard({
    super.key,
    required this.command,
    required this.discription,
    required this.name,
    // required this.copy
  });

  final String name;
  final String command;
  final String discription;
  //Function copy;

  @override
  Widget build(BuildContext context) {
    bool isScrolling = Provider.of<ScrollEventNotifier>(context).isScrolling;
    return TweenAnimationBuilder(
      tween:
          Tween(begin: isScrolling ? 0.0 : -0.2, end: isScrolling ? -0.2 : 0.0),
      duration: const Duration(milliseconds: 200),
      builder: (_, double rotation, _child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.01)
            ..rotateX(rotation),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isScrolling ? Colors.blue : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]),
            child: Card(
              color: const Color.fromARGB(255, 249, 249, 249),
              borderOnForeground: true,
              child: Column(
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      discription,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 57, 67, 67),
                    child: SizedBox(
                      width: 400,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(top: 1, left: 8, bottom: 5),
                          child: Text(
                            command,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 249, 243, 243),
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
