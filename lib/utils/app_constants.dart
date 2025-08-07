/// A centralized class for storing application-wide constants like URLs, tokens, keys, and versioning info.
class AppConstants {
  /// Name of the application.
  static const String APP_NAME = "DB Food";

  /// Current version of the application.
  static const int APP_VERSION = 1;

  // ----------------------- BASE URLs -----------------------

  /// Base URL of the backend server.
  /// Change this according to your development environment:
  /// - Emulator: 'http://10.0.2.2:3000/'
  /// - Localhost: 'http://localhost:3000/'
  /// - Physical Device (e.g. Android phone): use your local IP, e.g. 'http://192.168.x.x:3000/'
  static const String BASE_URL = 'http://192.168.100.41:3000';

  /// Subpath for uploaded image/static files.
  static const String UPLOAD = "/uploads/";

  // ----------------------- API Endpoints -----------------------

  /// API endpoint for fetching popular products.
  static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular";

  /// API endpoint for fetching recommended products.
  static const String RECOMMENDED_PRODUCT_URL = "/api/v1/products/recommended";

  // ----------------------- API Keys / Storage Keys -----------------------

  /// Key used to store and retrieve the token from local storage (e.g. shared preferences).
  static const String TOKEN = "DbToken";

  /// Key used to store the current cart items list in local storage.
  static const String cartKey = "cartList";

  /// Key used to store the cart history list in local storage.
  static const String cartHistoryKey = "cartHistory";
}