import 'dart:io';
import 'src/token.dart';
import 'src/scanner.dart';

bool hadError = false; 

main(List<String> args) {
  if (args.length > 1) {
    print("Usage: dlox [script]");
    exit(64);
  } else if (args.length == 1) {
    try {
      File file = new File(args[0]);
      run(file.readAsStringSync());
    } on FileSystemException {
      print("File doesn't exist");
    }
  } else {
    runPrompt();
  }
}

void run(String path) {
  Scanner scanner = new Scanner(path);
  List<Token> tokens = scanner.scanTokens();

  for (Token token: tokens) {
    print(token);
  }
  if (hadError) return;
}

void runPrompt() {
  while (true) {
    stdout.write("> ");
    String line = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
    Scanner scanner = new Scanner(line);
    List<Token> tokens = scanner.scanTokens();
    
    if (hadError) return;
  }
}

void error(int line, String message) {
  report(line, "", message);
}

void report(int line, String where, String message) {
  print("[line" + line + "] Error" + where + ": " + message);
  hadError = true;
}
