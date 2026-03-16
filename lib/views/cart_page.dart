import 'package:flutter/material.dart';
import 'package:mini_katalog_uygulamasi/model/product_model.dart';

class CartScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cartIds;
  const CartScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((product) => widget.cartIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 65,
                              color: Colors.orange.shade400,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Your Cart is Empty!",
                              style: TextStyle(
                                fontSize: 25,
                                color: const Color.fromARGB(255, 18, 42, 104),
                              ),
                            ),

                            SizedBox(height: 12),
                            Text(
                              "Add Items to Start Shopping!!!",
                              style: TextStyle(
                                fontSize: 25,
                                color: const Color.fromARGB(255, 18, 42, 104),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final item = cartProducts[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(item.image ?? ""),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 15),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? "",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(item.tagline ?? ""),
                                      Text(item.price ?? ""),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.cartIds.remove(item.id);
                                    });
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              SizedBox(height: 20),

              SizedBox(height:10),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color:Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border:Border.all(color:Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color:Colors.grey.shade500),
                    SizedBox(width: 8),
                    Text("Lorem Impus"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size.fromHeight(75),
                ),
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.orange.shade400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
