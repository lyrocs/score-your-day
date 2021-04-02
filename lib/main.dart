import 'package:flutter/material.dart';
import 'package:score_your_day/ui/home.dart';
import 'package:score_your_day/ui/score.dart';

void main() {
  runApp(ScoreYourDay());
}

class ScoreYourDay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app test',
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => Home(),
        '/score': (context) => ScorePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Home();
  }
}