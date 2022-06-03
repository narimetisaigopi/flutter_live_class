import 'package:flutter/material.dart';
import 'package:flutter_live_class/providers/cart_provider.dart';
import 'package:flutter_live_class/providers/count_provider.dart';
import 'package:flutter_live_class/providers/mycart.dart';
import 'package:provider/provider.dart';

class ProviderInc extends StatefulWidget {
  const ProviderInc({Key? key}) : super(key: key);

  @override
  State<ProviderInc> createState() => _ProviderIncState();
}

class _ProviderIncState extends State<ProviderInc> {
  CountProvider? countProvider;
  CartProvider? _cartProvider;

  Map productsMap = {"Milk": 70, "Chicken": 240, "Bread": 40, "Potato": 34};

  @override
  void initState() {
    super.initState();
    countProvider = Provider.of<CountProvider>(context, listen: false);
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print("build called.");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countProvider!.updateCount();
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
      appBar: AppBar(
        actions: [
          Consumer<CartProvider>(builder: (context, model, child) {
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) => MyCart()));
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    size: 32,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      child: Text(
                        "${model.myCart.length}",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
      body: Column(
        children: [
          Center(
              child: Consumer<CountProvider>(builder: (context, model, child) {
            return Text(
              "Count : ${model.count}",
              style: TextStyle(fontSize: 24),
            );
          })),
          ListView.builder(
              shrinkWrap: true,
              itemCount: productsMap.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(productsMap.keys.toList()[index].toString()),
                    subtitle: Text(
                        "\$" + productsMap.values.toList()[index].toString()),
                    trailing: Container(
                      width: 150,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _cartProvider!.addToCart(
                                  productsMap.keys.toList()[index],
                                  productsMap.values.toList()[index]);

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "${productsMap.keys.toList()[index]} added to cart.")));
                            },
                            child: Text("Add"),
                          ),
                          TextButton(
                            onPressed: () {
                              _cartProvider!.removeFromCart(
                                  productsMap.keys.toList()[index],
                                  productsMap.values.toList()[index]);

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "${productsMap.keys.toList()[index]} removed from cart.")));
                            },
                            child: Text("Remove"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
