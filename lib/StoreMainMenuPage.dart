import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping_app/LoginPage.dart';
import 'package:shopping_app/ShoppingBasket.dart';

import 'BranchesPage.dart';
import 'DescriptionPage.dart';
import 'Product.dart';
import 'ShopBottomNavigator.dart';



class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<Product> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "فروشگاه",
          style: TextStyle(color: Colors.black45, fontFamily: "Vazir"),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black45,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.map,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BranchesPage()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondAnimation) {
                    return ShoppingBasket();
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondAnimation,
                      Widget child) {
                    return SlideTransition(
                      child: child,
                      position:
                      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastOutSlowIn)),
                    );
                  }));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          children: List.generate(_items.length, (int position) {
            return generateItem(_items[position], context);
          }),
        ),
      ),
      bottomNavigationBar: ShopBottomNavigator(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }



  void fetchItems() async {
    var url = "http://welearnacademy.ir/flutter/products_list.json";
    Response response = await get(url);
    setState(() {
      var productJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in productJson) {
        var productItem = Product(i['product_name'], i['id'], i['price'],
            i['image_url'], i['off'], i['description']);
        _items.add(productItem);
      }
    });
  }
}

Card generateItem(Product product, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
    elevation: 4,
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DescriptionPage(product)));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              child: Image.network(product.imageUrl),
            ),
            Text(
              product.price,
              style: TextStyle(
                  fontFamily: "Vazir", color: Colors.red[700], fontSize: 16.0),
            ),
            Text(
              product.productName,
              style: TextStyle(
                  fontFamily: "Vazir",
                  color: Color(0xFF575E67),
                  fontSize: 14.0),
            )
          ],
        ),
      ),
    ),
  );
}

