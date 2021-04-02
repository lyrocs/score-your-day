import 'package:flutter/material.dart';
import 'package:score_your_day/bloc/score_bloc.dart';

class ScorePage extends StatefulWidget {
  ScorePage({Key key}) : super(key: key);

  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  var _score = scoreBloc.scoreSelected.score;
  var _comment = scoreBloc.scoreSelected.comment;
  var _date = scoreBloc.scoreSelected.date;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: _comment);
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: scoreBloc.getColor(_score),
      appBar: AppBar(
        backgroundColor: scoreBloc.getColor(_score),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
       child: Container(
          decoration: BoxDecoration(
            color: scoreBloc.getColor(_score),
          ),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('How is your day ?')],
              ),
              Padding(padding: EdgeInsets.all(30.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: scoreBloc.getImage(_score),
                    height: 200,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(30.0)),
              Slider(
                value: _score,
                min: 0,
                max: 100,
                divisions: 5,
                onChanged: (double value) {
                  setState(() {
                    _score = value;
                  });
                },
              ),
              // Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: _controller,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add a comment',
                      prefixIcon: Icon(Icons.message)
                  ),
                  onSubmitted: (value) {
                    _comment = value;
                  },
                  onChanged: (value) {
                    _comment = value;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () async {
                      await scoreBloc.saveScore(_date, _score, _comment);
                      Navigator.pushNamed(context, '/home');
                    },
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)
              ),
              // Padding(padding: EdgeInsets.all(30.0)),
            ],
          )),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      // items: const [Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //       child: Text('Save'),
      //       onPressed: () async {
      //         await scoreBloc.saveScore(_date, _score, _comment);
      //         Navigator.pushNamed(context, '/home');
      //       },
      //     )
      //   ],
      // )],
    );
  }
}
