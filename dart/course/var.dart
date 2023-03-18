
class Var1 {
  /* About 'var' and 'dynamic' keywords. */

  String nick = 'zae-park';

  void printNickname() {
    
    var nick;             // following Dart style guide, using 'var' keyword in any method. Same as `dynamic nick;`
    nick = 'Zae-park';    // Now 'nick' has String type.
    print(nick);
  }
}

class nullSatefy {
  /* About 'null safety'. How powerful it is! */

  String? nick;   // nick might be 'null';

  // Inline function: 
  //    void setNickname(String nickname) => nick = nickname;
  void setNickname(var nickname) {
    nick = nickname;
    lengthNickname();
  }

  void lengthNickname() {
    var length = nick!.length;          // '!' guarantee the variable must not be null.
    var maybeLength = nick?.length;     // if nick is not null, 'maybeLength' has same value with 'length'
    print('Length: $length');
    print('Length maybe...: $maybeLength');
    
  }

  void printNickname() {
    print(nick);
  }

  void run(var nickname) {
    setNickname(nickname);
    printNickname();
  }
}

class advVar {
  /* About 'final', 'late', and 'const' keywords. */

  final String nick = 'zae-park';   // nick cannot changed.

  // const String userID;   // must be known in compile-time.

  void changeNickname() {
    late var Nick;                    // late variable 'Nick' assigned in future.

    print('Before...');
    print('\t nick: $nick');
    // print('\t Nick: $Nick');       // 'Nick' is not assigned yet.

    // nick = 'zae-park';  // Assignment to final variable error.
    Nick = 'jae-park';

    print('After...');
    print('\t nick: $nick');
    print('\t Nick: $Nick');
  }

}
