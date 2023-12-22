import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15,),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15,),
              child: Text(
                  "See all",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height/4.99,
          padding: const EdgeInsets.only(left: 10,
          right: 0,
          top: 20,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index){

            return GestureDetector(
              onTap: (){},
              child: const SingleProduct(image: "https://media.istockphoto.com/id/1573329496/photo/multi-layers-color-texture-3d-papercut-layers-in-gradient-vector-banner-carving-art-cover.jpg?s=1024x1024&w=is&k=20&c=EmGEp2Z1LJmjaxofvy_hxMgyIe0t_39Ophh-CG74_Vc=",),);
          },),
        ),
      ],
    );
  }
}
