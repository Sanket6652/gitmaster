import 'package:flutter/material.dart';

class LessonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> lesson;

  LessonDetailScreen({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final steps = lesson['Steps'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson['LessonTitle']),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.white,
          ),
        child: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (context, index) {
            final step = steps[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        step['Description'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(step['Explanation']),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Step ${step['StepNumber']}'),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
