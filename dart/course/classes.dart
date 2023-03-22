// Use 'enum' to prevent typo and unexpected arguments
enum GENDER {male, female, bisexual, queer, lesbian, homosexual, homoRomanceAsexualAndrogynous}


abstract class Human {
  final String name;
  Human({required this.name});
}

abstract class Regist {
  String grade;
  Regist({required this.grade});

  void whatGrade() {
    print(grade);
  }
}

class Payment {
  int dollar = 100;
}

class Member extends Regist with Payment{
  Member(grade, pay) : super(grade: grade);
  
  // Cannot change mixin's property
  // int dollar = pay;
}

class Manager extends Regist with Payment{
  Manager(grade) : super(grade: grade);
}

class Player {
  late final String familyName; // property who use 'final' cannot changed.
  // const _nickName = 'zae';    // 'const' keyword is used to static field variables.
  String name;
  int age;
  GENDER? gender;
  

  // // Constructor #1
  // Player(String name, int age, [String _familyName = 'park']) {
  //   this.name = name;
  //   this.age = age;
  //   this._familyName = _familyName;
  // }

  // Constructor #2
  Player({required this.name, required this.age, String familyName = 'park'});


  // Using factory

  Player.createMale({required String name, required int age, String familyName = 'park'}) :
  this.name = name,
  this.age = age,
  this.familyName = familyName,
  this.gender = GENDER.male
  ;

  Player.createFemale({required String name, required int age, String familyName = 'park'}) :
  this.name = name,
  this.age = age,
  this.familyName = familyName,
  this.gender = GENDER.female
  ;

  void greeting(String name) {
    print('Greetings! My name is ${this.familyName}. Locally, $name');
  }

  void walk() {
    print('walking...');
  }
}


void cascadedInstance() {
  // Exmaple of factory
  var someMan = Player(familyName: 'park', name: 'Tom', age: 12);
  var someWoman = Player(name: 'Jerry', age: 10);

  // Example of cascade operation
  var someOne = Player(name:'donald', age: 18)
    ..name = 'Mickey'
    ..age = 22
    ..gender = GENDER.male
  ;

}