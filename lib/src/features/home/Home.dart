import 'package:demo_app/src/core/routes/AppRouter.dart';
import 'package:demo_app/src/features/products/ProductModel.dart';
import 'package:flutter/material.dart';
import '../products/ProductRepository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  int cartCount = 0; // cart badge counter
  List<Product> cartProducts = [];
  ProductRepository productRepository = ProductRepository();
  @override
  void initState() {
    super.initState();
    products = productRepository.products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  print("Total cart items: ${cartProducts.length}");
                  // TODO: navigate to cart screen
                  Navigator.pushNamed(context, AppRouter.cart, arguments: {
                    'cartProducts': cartProducts,
                    'productRepository': productRepository,
                  });
                },
              ),
              if (cartProducts.length > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartProducts.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      productRepository.addToCart(products[index]);
                      cartProducts = productRepository.getCartItems();
                      print("Count is ${cartProducts.length}");
                    });
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/images/${products[index].name}.png",
                      width: 80,
                      height: 80,
                    ),
                    title: Text(products[index].name),
                    trailing: Text("\$${products[index].price}"),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1, color: Colors.grey, indent: 20),
            ),
          ),
        ],
      ),
    );
  }
}

