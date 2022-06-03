import 'package:flutter/material.dart';
import 'package:flutter_live_class/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<CartProvider>(builder: (context, model, child) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: model.myCart.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text("${index + 1}"),
                title: Text(model.myCart.keys.toList()[index].toString()),
                subtitle:
                    Text("\$" + model.myCart.values.toList()[index].toString()),
                // trailing: ElevatedButton(
                //   onPressed: () {
                //     _cartProvider!.addToCart(productsMap.keys.toList()[index],
                //         productsMap.values.toList()[index]);

                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Text(
                //             "${productsMap.keys.toList()[index]} added to cart.")));
                //   },
                //   child: Text("Add"),
                // ),
              ),
            );
          });
    }));
  }
}
