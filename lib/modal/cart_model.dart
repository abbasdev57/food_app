import 'popular_product_modal.dart';

/// A model representing an item in the shopping cart.
class CartModal {
  /// The unique identifier of the cart item (usually matches product ID).
  int? id;

  /// The name of the product.
  String? name;

  /// The price of the product (integer for cents or whole value).
  int? price;

  /// The URL or path to the product image.
  String? img;

  /// The number of units of this product in the cart.
  int? quantity;

  /// Whether this product still exists in stock.
  bool? isExist;

  /// The time when this product was added to the cart.
  String? time;

  /// The full product object linked to this cart item.
  ProductModel? product;

  /// Creates a [CartModal] object with optional and required fields.
  CartModal({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    required this.isExist, // Required because stock status is important
    this.time,
    this.product,
  });

  /// Creates a [CartModal] object from a JSON map.
  /// Useful for decoding API responses.
  CartModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    // Deserialize product object if present
    product = ProductModel.fromJson(json['product']);
  }

  /// Converts this [CartModal] instance into a JSON map.
  /// Useful for sending data to APIs or local storage.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'img': img,
    'quantity': quantity,
    'isExist': isExist,
    'time': time,
    // Only include product JSON if it's not null
    'product': product?.toJson(),
  };
}
