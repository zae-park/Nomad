class arr {
  /* Aboud 'List', 'string interpolation' and 'Collection' */
  List<int> intergers = [0, 1, 2, 3, 4];
  List<double> realNumbers = [0.0, 1.1, 2.2, 3.3, 4.4];

  List<int> age = [15, 11, 26, 31, 9, 27];
  List<bool> earlyBirth = [true, false, false, false, true];

  List<String> user = ['A', 'B', 'C', 'D'];

  void greeting(String name, int age) {
    print('My name is $name and i\'m $age year(s) old.');   // String interpolation
  }

  void collectios() {
    var newUser = ['Z', 'Y', 'X', for (var _user in user) _user];   // List collection

    Map<String, int> userInfo = {'A': 15, 'B': 11, 'C': 26, 'D': 31}; // Map
    print(userInfo);
  }

}