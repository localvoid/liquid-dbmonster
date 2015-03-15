library components.popover;

import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;

final popover = v.componentFactory(Popover);
class Popover extends Component {
  @property(required: true) String query;

  build() =>
    v.root(classes: const ['popover', 'left'])([
      v.div(type: 'popover-content')(query),
      v.div(type: 'arrow')
    ]);
}
