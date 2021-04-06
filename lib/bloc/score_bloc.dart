import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:score_your_day/model/score_model.dart';
import 'package:score_your_day/persistence/repository.dart';

class ScoreBloc {
  Repository _repository = Repository();

  final _scoreFetcher = PublishSubject<List<Score>>();
  var _scoreSelected;

  Observable<List<Score>> get scores => _scoreFetcher.stream;
  Score get scoreSelected => _scoreSelected;

  setSelectedScore(value) {
    _scoreSelected = value;
  }

  initSelectedScore() {
    _scoreSelected = Score(
        DateTime.now().toString().substring(0, 10),
        60.0,
        ''
    );
  }

  fetchScores() async {
    List<Score> scoreResponse = await _repository.fetchAll();
    _scoreFetcher.sink.add(scoreResponse);
  }

  saveScore(date, score, comment) async {
    return _repository.saveScore(date, score, comment);
  }

  changeSelectedDate(int diffDay) async {
    var currentDate = DateTime.parse(_scoreSelected.date);
    var previousDate;
    if (diffDay > 0) {
      previousDate = currentDate.add(const Duration(days: 1)).toString().substring(0, 10);
    } else if (diffDay < 0) {
      previousDate = currentDate.subtract(const Duration(days: 1)).toString().substring(0, 10);
    }

    Score previousScore = await _repository.fetchOneByDate(previousDate);
    print(previousScore);
    if (previousScore != null) {
      _scoreSelected = previousScore;
    } else {
      _scoreSelected = new Score(previousDate.toString().substring(0, 10), 60.0, '');
    }
  }


  getColor(value) {
    if (value == 0.0) {
      return Color(0xfff83b32);
    } else if (value == 20.0) {
      return Color(0xfffd6d00);
    } else if (value == 40.0) {
      return Color(0xfff89245);
    } else if (value == 60.0) {
      return Color(0xfff89245);
    } else if (value == 80.0) {
      return Color(0xffffd401);
    } else if (value == 100.0) {
      return Color(0xff4afc00);
    }
  }

  getImage(value) {
    if (value == 0.0) {
      return AssetImage('assets/emojis/angry.png');
    } else if (value == 20.0) {
      return AssetImage('assets/emojis/confused.png');
    } else if (value == 40.0) {
      return AssetImage('assets/emojis/sad.png');
    } else if (value == 60.0) {
      return AssetImage('assets/emojis/happy.png');
    } else if (value == 80.0) {
      return AssetImage('assets/emojis/shy.png');
    } else if (value == 100.0) {
      return AssetImage('assets/emojis/love.png');
    }
  }

  dispose() {
    _scoreFetcher.close();
  }
}

final scoreBloc = ScoreBloc();
