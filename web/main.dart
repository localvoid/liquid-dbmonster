import 'dart:async';
import 'dart:html' as html;
import 'package:liquid/liquid.dart';
import 'data.dart';
import 'components/main.dart';

const int I = 0;
const int N = 100;

void update(List<Database> dbs) {
  for (final db in dbs) {
    db.update();
  }
}

void main() {
  List<Database> dbs = [];
  for (var i = 0; i < N; i++) {
    dbs.add(new Database('cluster${i}'));
    dbs.add(new Database('cluster${i}slave'));
  }

  final app = new Main()..dbs = dbs;
  injectComponent(app, html.document.body);

  new Timer.periodic(const Duration(milliseconds: I), (t) {
    update(dbs);
    app.invalidate();
  });
}
