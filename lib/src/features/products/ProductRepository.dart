import 'ProductModel.dart';

class ProductRepository {
  List<Product> products = [
    Product(1, "Mac", 2150.0),
    Product(2, "iPhone", 95.0),
    Product(3, "iPods", 130.0),
    Product(4, "Bottle", 10.0),
    Product(5, "Book", 30.0),
    Product(6, "Glass", 50.0),
  ];

List<Product> _addedProducts = [];
double total = 0.0;
double discountedTotal = 0.0;

  void addToCart(Product item) {
    // Logic to add product to cart
    print("TRying to Add to cart: ${item.name}");
    if (!_addedProducts.contains(item)) {
      _addedProducts.add(item);
      print("Added to cart: ${item.name}");
    } else {
      _addedProducts.firstWhere((p) => p.id == item.id).quantity += 1;
      // product.quantity += 1;
    }
  }

  List<Product> getCartItems() {
    print("cARt products: ${_addedProducts.length}");
    return _addedProducts;
    // Logic to get cart items
    // for (var product in _products) {
    //   print(
    //       "Product: ${product.name}, Price: ${product.price}, Quantity: ${product.quantity}");
    // }
  }
  double getTotalAmount() {
    total = _addedProducts.fold(0, (total, current) => total + (current.price * current.quantity));
    return total;
  }

double applyDiscount({double discount = 10.0}) {
    //     for (var item in _products) {
    //       total += item.price;
    //     }
    //     print("Total us $total & discount is ${discount/100}");
    return total = total - (total * (discount / 100));
  }
}