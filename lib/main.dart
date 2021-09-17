import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping_app/LoginPage.dart';
import 'package:shopping_app/ShoppingBasket.dart';

import 'BranchesPage.dart';
import 'DescriptionPage.dart';
import 'Product.dart';
import 'ShopBottomNavigator.dart';

void main() => runApp(MainMaterial());

class MainMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginWidget(),
    );
  }
}
