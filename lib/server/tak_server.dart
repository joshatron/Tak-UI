abstract class TakServer {
  void initialize(String username, String password, String server);
  String getUsername();
  String getServer();

  Future<bool> register();
  Future<bool> isAuthenticated();
  bool localAuth(String password);
  Future<bool> changeUsername(String username);
  Future<bool> changePassword(String password);
}