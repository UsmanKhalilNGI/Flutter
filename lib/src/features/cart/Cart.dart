import 'package:flutter/material.dart';
import 'package:demo_app/src/features/products/ProductModel.dart';
import 'package:flutter/material.dart';
import '../products/ProductRepository.dart';

class Cart extends StatelessWidget {
  // final List<Product> cartProducts;
  // final ProductRepository productRepository;
  const Cart({super.key});
  // const Cart({super.key, required this.cartProducts, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final TextEditingController _controller = TextEditingController();

    final cartProducts = args['cartProducts'] as List<Product>;
    final productRepository = args['productRepository'] as ProductRepository;
    double totalAmount = productRepository.getTotalAmount();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart Page")),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: Text("${cartProducts[index].name}"),
                trailing: Text(
                  "\$${(cartProducts[index].price).toStringAsFixed(2)} (x${cartProducts[index].quantity})",
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // 👈 this gives space to the TextField
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right : 8.0),
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              labelText: "Enter your coupon",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle apply coupon action
                           print("Total after discount: ${_controller.text}");
                           productRepository.applyDiscount(discount: double.tryParse(_controller.text) ?? 0.0);  
                            totalAmount = productRepository.getTotalAmount();
                            print("Total after discount: $totalAmount");
                            
                        },
                        child: const Text("Apply"),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle checkout action
                        },
                        child: const Text("Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 100,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     padding: const EdgeInsets.all(20),
          //     color: Colors.white,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         const Text(
          //           "Total Amount",
          //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //         ),
          //         Text(
          //           "\$${productRepository.getTotalAmount().toStringAsFixed(2)}",
          //           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
