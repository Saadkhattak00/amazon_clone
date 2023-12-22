import 'package:amazon_clone/common/widgets/Loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product_Model? product;
  final HomeServices homeServices = HomeServices();

  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Loader();
    } else {
      return GestureDetector(
        onTap: navigateToDetailsScreen,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: const Text(
                'Deal of the day',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Image.network(
              product!.images[0],
              height: 235,
              fit: BoxFit.fitHeight,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                "\$${product!.price}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
              child: Text(
                product!.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: product!.images
                      .map(
                        (e) => Image.network(
                          e,
                          fit: BoxFit.contain,
                          height: 100,
                          width: 100,
                        ),
                      )
                      .toList()),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ).copyWith(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'See all deals',
                style: TextStyle(color: Colors.cyan[800]),
              ),
            )
          ],
        ),
      );
    }
  }
}
