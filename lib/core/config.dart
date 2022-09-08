class Config {
  static final Config _instance = Config._internal();

  Config._internal();

  factory Config() => _instance;

  /// ----------------------
  /// | untuk URL Rest API |
  /// ----------------------
  static const String ENDPOINT = "http://192.168.137.1:3000/";

}
