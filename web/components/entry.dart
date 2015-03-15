library components.entry;

import 'dart:html' as html;
import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;
import 'popover.dart';
import '../data.dart';

String _formatElapsed(double v) {
  if (v == 0) return '';

  String result = v.toStringAsFixed(2);

  if (v > 60) {
    int minutes = (v / 60).floor();
    List<String> comps = (v % 60).toStringAsFixed(2).split('.');
    String seconds = comps[0].padLeft(2, '0');
    String ms = comps[1];
    result = '$minutes:$seconds.$ms';
  }

  return result;
}

List _countClasses(int count) {
  if (count >= 20) {
    return const ['label-important'];
  } else if (count >= 10) {
    return const ['label-warning'];
  }
  return const ['label-success'];
}

final entry = v.componentFactory(Entry);
class Entry extends Component {
  @property(required: true) Database db;

  void create() {
    element = new html.TableRowElement();
  }

  build() {
    final children = [
      v.td(type: 'dbname')(db.name),
      v.td(type: 'query-count')(v.span(type: 'label', classes: _countClasses(db.queries.length))(db.queries.length.toString()))
    ];

    final queries = db.getTopFiveQueries();

    for (final q in queries) {
      var classes = [];
      classes.add('elapsed');
      if (q.elapsed >= 10.0) {
        classes.add('warn_long');
      } else if (q.elapsed >= 1.0) {
        classes.add('warn');
      } else {
        classes.add('short');
      }
      children.add(v.td(type: 'Query', classes: classes)([
        v.text(_formatElapsed(q.elapsed)),
        popover(query: q.query)
      ]));
    }

    return v.root(children: children);
  }
}
