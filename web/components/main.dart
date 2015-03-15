library components.main;

import 'dart:html' as html;
import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;
import '../data.dart';
import 'entry.dart';

final main = v.componentFactory(Main);
class Main extends Component {
  @property() List<Database> dbs;

  void create() {
    element = new html.TableElement();
  }

  build() =>
    v.root(classes: const ['table', 'table-striped', 'latest-data'])(
        new v.VHtmlGenericElement('tbody')(dbs.map((db) => entry(key: db.id, db: db)))
    );
}
