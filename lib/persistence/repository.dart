import 'package:score_your_day/model/score_model.dart';


import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class Repository {
  Future<List<Score>> fetchAll() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, 'my_database.db');
    var db = await databaseFactoryIo.openDatabase(dbPath);
    var store = intMapStoreFactory.store();
    var list = await store.find(db,
        finder: Finder(sortOrders: [SortOrder('date', false)]));

    List<Score> result = [];
    list.forEach((element) {
      result.add(new Score(element['date'], element['score'], element['comment']));
    });
    return result;
  }

  Future<Score> fetchOneByDate(date) async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, 'my_database.db');
    var db = await databaseFactoryIo.openDatabase(dbPath);
    var store = intMapStoreFactory.store();
    var element = await store.findFirst(db,
        finder: Finder(filter: Filter.equals('date', date)));

    if (element == null) {
      return null;
    }
    Score result = new Score(element['date'], element['score'], element['comment']);
    return result;
  }


  Future<bool> saveScore(date, score, comment) async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, 'my_database.db');
    var db = await databaseFactoryIo.openDatabase(dbPath);
    var store = intMapStoreFactory.store();

    await store.delete(db, finder: Finder(filter: Filter.equals('date', date)));
    await store.add(db, {'date': date, 'score': score, 'comment': comment});
    return true;
  }
}
