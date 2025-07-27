import 'package:dart_typedef/dart_typedef.dart' as dart_typedef;

void main(List<String> arguments) {
  dart_typedef.handle((value) => print(value));
  dart_typedef.handle(dart_typedef.hello);
  dart_typedef.handle(dart_typedef.myCallback);
  for (final panelLocation in panels) {
    dart_typedef.printPanelInfo(panelLocation);
  }
  print(data);
  for (var (index, panel) in positions) {
    print('Index: $index, Panel: $panel');
  }
}

List<dart_typedef.PanelLocation> panels = [
  (0, dart_typedef.Panel.upper),
  (1, dart_typedef.Panel.lower),
  (2, dart_typedef.Panel.upper),
];

dart_typedef.MyData data = {
  "scores": [1, 2, 3],
};

List<(int, dart_typedef.Panel)> positions = [
  (0, dart_typedef.Panel.upper),
  (1, dart_typedef.Panel.lower),
];
