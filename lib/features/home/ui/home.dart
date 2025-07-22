import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/features/cart/ui/cart.dart';
import 'package:flutter_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_app/features/home/ui/home_product_tile_widget.dart';
import 'package:flutter_bloc_app/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          ).then((_) {
            homeBloc.add(HomeInitialEvent());
          });
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Wishlist()),
          );
        }
        else if (state is HomeProductWishlistButtonClickedActionState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Added to Wishlist"),
              duration: Duration(seconds: 2),
            ),
          );
        }
        else if (state is HomeProductCartButtonClickedActionState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Added to Cart"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator()));

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Grocery App",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.blue,
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    productDataModel: successState.products[index],
                    cartItems: successState.cartItems,
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          case HomeErrorState:
            return Scaffold(body: Center(child: Text("Error")));
          default:
            return Container();
        }
      },
    );
  }
}
