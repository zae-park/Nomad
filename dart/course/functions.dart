void printSomething(String something) => print(something);
void printUnNecessary(List<dynamic> something, [String ignoreArgs = 'dummy']) => print(ignoreArgs);
String NICKNAME(String? nick) => nick?.toUpperCase() ?? 'NONAME';

// typedef:
//    Using powerful alias for ambiguous var type.

typedef IntList = List<int>;

List<int> reverseList(List<int> list) => list.reversed.toList();
IntList reverseListWithAlias(IntList list) => list.reversed.toList();
