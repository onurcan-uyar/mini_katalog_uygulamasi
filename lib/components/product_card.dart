import 'package:flutter/material.dart';
import 'package:mini_katalog_uygulamasi/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;

  const  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: product.id ?? 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.vertical(
                                    top: Radius.circular(12),
                                    bottom: Radius.circular(12),
                                  ),
                                  child: Image.network(product.image ?? ""),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 1),
                                  
                                  Text(
                                    product.tagline ?? "",
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 219, 150, 14),
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  
                                  SizedBox(height: 1),
                                  Text(product.price ?? "N/A",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[300],
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    ;
  }
}