// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/Provider/user_provider.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  // ADD TO CART API
  void AddToCart({
    required BuildContext context,
    required Product_Model product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id!,}),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User_model user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // FETCHING RATING API
  void rateProduct({
    required BuildContext context,
    required Product_Model product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
