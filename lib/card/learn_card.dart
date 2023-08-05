import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../scrolleventnotifier.dart';

class learnCard extends StatelessWidget {
  learnCard({
    super.key,
    required this.lessonname,
    //required this.press
  });

  final String lessonname;
  // Function press;

  @override
  Widget build(BuildContext context) {
    bool isScrolling = Provider.of<ScrollEventNotifier>(context).isScrolling;
    return TweenAnimationBuilder(
        tween: Tween(
            begin: isScrolling ? 0.0 : -0.2, end: isScrolling ? -0.2 : 0.0),
        duration: Duration(milliseconds: 200),
        builder: (_, double rotation, _child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.01)
              ..rotateX(rotation),
            alignment: Alignment.center,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isScrolling ? Colors.blue : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                //borderOnForeground: true,
                //elevation: 5,
                child: Center(
                  child: Text(
                    lessonname,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
