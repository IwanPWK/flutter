class NumbersList {
  // Singleton pattern ensures that only one instance of NumbersList exists throughout app
  static final NumbersList _instance = NumbersList._internal();
  // Common way, using constructor
  // NumbersList()

  // Singleton pattern ensures that only one instance of NumbersList exists throughout app
  factory NumbersList() {
    return _instance;
  }
  // Singleton pattern ensures that only one instance of NumbersList exists throughout app
  NumbersList._internal();
  List<int> numbers = [];
}
