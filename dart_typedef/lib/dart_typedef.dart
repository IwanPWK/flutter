// common example typedef
typedef MyCallback = void Function(String value);

void handle(MyCallback callback) {
  callback("Hello");
}

void hello(String value) {
  print(value);
}

MyCallback myCallback = (value) {
  print(value);
};

enum Panel { upper, lower }

// record type
typedef PanelLocation = (int, Panel);

void printPanelInfo(PanelLocation location) {
  final index = location.$1;
  final panel = location.$2;

  print("Panel ke-$index berada di ${panel.name}");
}

typedef MyData = Map<String, List<int>>;

//==========================================================================//
// example record type
(int, Panel) myRecord = (3, Panel.upper);
// list of record
List<(int, Panel)> listOfRecords = [(1, Panel.upper), (2, Panel.lower)];

// generic type
List<int> myList = [1, 2, 3];
Map<String, int> myMap = {"a": 1, "b": 2, "c": 3};

// list record type
List<(int, Panel)> panelList = [(0, Panel.upper), (1, Panel.lower)];

// alternative, using typedef
typedef PanelLoc = (int, Panel);

List<PanelLoc> panels = [(0, Panel.upper), (1, Panel.lower), (2, Panel.upper)];

//==========================================================================//
