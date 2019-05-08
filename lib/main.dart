import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Rectangle',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Rectangle'),
        ),
        body: TestApp(),
      ),
    ),
  );
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                key: Key('inputKeyString'),
                onChanged: (value) {
                  print(value);
                },
              ),
              RaisedButton(
                key: Key('button'),
                child: Text('Press me'),
                onPressed: () {
                  print('pressed');
                },
              ),
              SizedBox(
                height: 600,
              ),
              Text(
                'Scroll till here',
                key: Key('text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}