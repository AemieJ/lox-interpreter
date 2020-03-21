import 'token.dart';
import '../main.dart';

class Scanner {
  /* Dart doesn't have a char type hence use its unicode. */
  /* const keyword is used when the value of variable is known during compile time. final keyword is used when the value of variable isn't known during the compile 
     time. */
  static const int LEFT_PAREN = 0x28;
  static const int RIGHT_PAREN = 0x29;
  static const int LEFT_BRACE = 0x7B;
  static const int RIGHT_BRACE = 0x7D;
  static const int COMMA = 0x2C;
  static const int DOT = 0x2E;
  static const int MINUS = 0x2D;
  static const int PLUS = 0x2B;
  static const int SEMICOLON = 0x3B;
  static const int SLASH = 0x2F;
  static const int STAR = 0x2A;
  static const int BANG = 0x21;
  static const int EQUAL = 0x3D;
  static const int LESS = 0x3C;
  static const int GREATER = 0x3E;
  static const int NULL = 0x00;

  static const LF = 0xA;
  static const CR = 0xD;
  static const SP = 0x20;
  static const TAB = 0x9;

  static const DOUBLE_QUOTE = 0x22;

  static const ZERO = 0x30;
  static const NINE = 0x39;
  static const LETTER_A = 0x61;
  static const LETTER_Z = 0x7A;
  static const LETTER__CAP_A = 0x41;
  static const LETTER__CAP_Z = 0x5A;
  static const UNDERSCORE = 0x5F;

  final String _source;
  final List<Token> _tokens = new List<Token>();

  int _start = 0;
  int _current = 0;
  int _line = 1;

  Scanner(String _source) {
    this._source = _source;
  }

  List<Token> scanTokens() {
    while(!isAtEnd()) {
      _start = _current;
      _scanToken();
    }
    _tokens.add(new Token(EOF, "", null, _line));
    return _tokens;
  }

  void _scanToken() {
      int _c = advance();
      switch(c) {
        case LEFT_PAREN  = _addToken(TokenType.LEFT_PAREN); break;
        case RIGHT_PAREN = _addToken(TokenType.RIGHT_PAREN); break;
        case LEFT_BRACE  = _addToken(TokenType.LEFT_BRACE); break;
        case RIGHT_BRACE = _addToken(TokenType.RIGHT_BRACE); break;
        case COMMA       = _addToken(TokenType.COMMA); break;
        case DOT         = _addToken(TokenType.DOT); break;
        case MINUS       = _addToken(TokenType.MINUS); break; 
        case PLUS        = _addToken(TokenType.PLUS); break;   
        case SEMICOLON   = _addToken(TokenType.SEMICOLON); break;    
        case START       = _addToken(TokenType.STAR); break;
      }
  }

  int _advance() {
      _current++;
      return source.codeUnitAt(_current);
  }

  _addToken(TokenType type, null);
  void _addToken(TokenType type, Object literal) {
      String _text = source.substring(start, current);
      _tokens.add(new Token(type, _text, literal, _line));
  }


  bool isAtEnd() {
    return _current >= source.length();
  }
}