import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_your_day/bloc/score_bloc.dart';
import 'package:score_your_day/model/score_model.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<Home> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff360101);
  final secondary = Color(0xfff35308);

  @override
  Widget build(BuildContext context) {
    scoreBloc.fetchScores();
    return Scaffold(
        body: StreamBuilder(
            stream: scoreBloc.scores,
            builder: (context, AsyncSnapshot<List<Score>> snapshot) {
              if (snapshot.hasData) {
                return _buildHomeScreen(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          scoreBloc.initSelectedScore();
          Navigator.pushNamed(context, '/score');
        },
        tooltip: 'Add score',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  ListView _buildHomeScreen(List<Score> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var project = data[index];
        return Column(
          children: <Widget>[
            // Widget to display the list of project
            GestureDetector(
                onTap: () {
                  scoreBloc.setSelectedScore(project);
                  Navigator.pushNamed(context, '/score');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xfff6f2ea),
                    border: Border.all( color: secondary),
                  ),
                  width: double.infinity,
                  height: 110,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 3, color: secondary),
                          image: DecorationImage(
                              image: scoreBloc.getImage(project.score), fit: BoxFit.fill),
                          color: scoreBloc.getColor(project.score),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              DateFormat('d LLLL y')
                                  .format(DateTime.parse(project.date))
                                  .toString(),
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.message,
                                  color: secondary,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                      project.comment != null
                                          ? project.comment
                                          : '',
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 13,
                                          letterSpacing: .3)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ),
          ],
        );
      },
    );
  }
}
