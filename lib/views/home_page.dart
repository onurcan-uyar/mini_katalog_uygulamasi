import 'package:flutter/material.dart';
import 'package:mini_katalog_uygulamasi/components/product_card.dart';
import 'package:mini_katalog_uygulamasi/model/product_model.dart';
import 'package:mini_katalog_uygulamasi/services/api_service.dart';
import 'package:mini_katalog_uygulamasi/views/cart_page.dart';
import 'package:mini_katalog_uygulamasi/views/product_detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool isloading = false;
  String errorMessage = "";
  List<Data> allProducts = [];
  ApiService apiService = ApiService();
  final Set<int> cartIds = {};

  String searchQuery ="";

  @override
  void initState() {
    loadProducts();

    super.initState();
  }

  Future<void> loadProducts() async {
    try {
      setState(() {
        isloading = true;
      });

      ProductModel resData = await apiService.fetchProducts();

      setState(() {
        allProducts = resData.data ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to Load Products!";
      });
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    final filteredProducts = allProducts.where((product) {
      final name = product.name ?? "";
      return name.toUpperCase().contains(searchQuery.toUpperCase());
    }).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover Products",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => CartScreen(
                        products: allProducts, 
                        cartIds: cartIds
                          ),
                         ),
                        );
                    },
                    iconSize: 30,
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Discover New Technology",
                style: TextStyle(fontSize: 15, color: Colors.yellow[800]),
              ),
              SizedBox(height: 15),

              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(15, 104, 104, 104),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search Products",
                    hintStyle: TextStyle(color: Colors.yellow[800]),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 15),

              Container(
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://wantapi.com/assets/banner.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              SizedBox(height: 15),

              if (isloading)
                Center(child: CircularProgressIndicator())
              else if (errorMessage != "")
                Center(child: Text(errorMessage))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product,
                                cartIds: cartIds,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(product: product),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
