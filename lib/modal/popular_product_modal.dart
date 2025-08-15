/// Represents a collection of products with some metadata such as total size, type, and offset.
class Product {
  int? _totalSize; // Total number of products available (e.g., from server)
  int? _typeId; // Category/type identifier for the products
  int? _offset; // Used for pagination (start index of the current product list)
  late List<ProductModel> _products; // List holding actual product data

  /// Public getter to access products list
  List<ProductModel> get products => _products;

  /// Constructor for creating a [Product] object manually.
  ///
  /// - [totalSize]: Total number of products available.
  /// - [typeId]: The category/type ID of the products.
  /// - [offset]: The pagination offset.
  /// - [products]: The list of products.
  Product({
    required int totalSize,
    required int typeId,
    required int offset,
    required products,
  }) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products ?? []; // Ensures products is always initialized
  }

  /// Creates a [Product] object from a JSON map.
  ///
  /// Expected JSON format:
  /// ```json
  /// {
  ///   "total_size": 100,
  ///   "type_id": 1,
  ///   "offset": 0,
  ///   "products": [ { ... }, { ... } ]
  /// }
  /// ```
  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];

    // Convert each JSON product into a ProductModel object
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    } else {
      _products = [];
    }
  }
}

/// Represents a single product with details like name, price, image, etc.
class ProductModel {
  int? id; // Unique identifier for the product
  String? name; // Product name
  String? description; // Product description
  double? price; // Product price
  String? img; // Product image URL/path
  int? stars; // Product rating (e.g., 1–5 stars)
  String? location; // Location where the product is available
  String? createdAt; // Product creation date
  String? updatedAt; // Last updated date for the product
  int? typeId; // Category/type ID of the product

  /// Constructor for manually creating a [ProductModel].
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.img,
    this.createdAt,
    this.location,
    this.stars,
    this.typeId,
    this.updatedAt,
  });

  /// Creates a [ProductModel] from a JSON map.
  ///
  /// Example JSON:
  /// ```json
  /// {
  ///   "id": 1,
  ///   "name": "Burger",
  ///   "description": "Delicious chicken burger",
  ///   "price": 5.99,
  ///   "img": "burger.png",
  ///   "stars": 5,
  ///   "location": "Lahore",
  ///   "created_at": "2025-08-12",
  ///   "updated_at": "2025-08-12",
  ///   "type_id": 2
  /// }
  /// ```
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price']?.toDouble();
    img = json['img'];
    stars = json['stars'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  /// Converts the [ProductModel] object into a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['img'] = img;
    data['stars'] = stars;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }
}
