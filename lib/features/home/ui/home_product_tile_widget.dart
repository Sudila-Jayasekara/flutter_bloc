import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_app/features/home/models/product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final List<ProductDataModel> cartItems;
  final HomeBloc homeBloc;
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + productDataModel.price.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeProductWishlistButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite_border),
                    // icon: cartItems.contains(productDataModel)
                    //     ? Icon(Icons.favorite, color: Colors.red)
                    //     : Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                    },
                    icon:
                        cartItems.any((item) => item.id == productDataModel.id)
                            ? Icon(Icons.shopping_cart, color: Colors.green)
                            : Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
