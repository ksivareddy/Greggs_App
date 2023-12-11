import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_details.dart';
import 'widgets/common_appbar.dart';
import 'listitem/product_grid_item.dart';
import 'model/product.dart';
import 'provider/cart_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> productList = [
      Product(
        articleCode: "1000446",
        shopCode: "1234",
        availableFrom: DateTime.parse("2020-12-30T00:00:00Z"),
        availableUntil: DateTime.parse("2024-05-13T23:59:59Z"),
        eatOutPrice: 1.05,
        eatInPrice: 1.15,
        articleName: "Sausage Roll",
        dayParts: ["Breakfast", "Lunch", "Evening"],
        internalDescription: "Sausage Roll",
        customerDescription:
            "The Nation’s favourite Sausage Roll.\n\nMuch like Elvis was hailed the King of Rock, many have appointed Greggs as the (unofficial) King of Sausage Rolls.\n\nFreshly baked in our shops throughout the day, this British classic is made from seasoned sausage meat wrapped in layers of crisp, golden puff pastry, as well as a large dollop of TLC. It’s fair to say, we’re proper proud of them.\n\nAnd that’s it. No clever twist. No secret ingredient. It’s how you like them, so that’s how we make them.\n\n",
        imageUri:
            "https://articles.greggs.co.uk/images/1000446.png?1623244287449",
        thumbnailUri:
            "https://articles.greggs.co.uk/images/1000446-thumb.png?1623244287450",
      ),
      //dummy products
      Product(
        articleCode: '1000447',
        shopCode: '1234',
        availableFrom: DateTime.parse("2022-01-01T00:00:00Z"),
        availableUntil: DateTime.parse("2045-05-13T23:59:59Z"),
        eatOutPrice: 3.25,
        eatInPrice: 3.35,
        articleName: 'Chicken Roll',
        dayParts: ['Breakfast', 'Lunch', 'Evening'],
        internalDescription: 'Chicken Sausage Roll',
        customerDescription:
            'Delicious chicken sausage roll with a blend of spices.'
            'Perfect for any time of the day. \n\nChicken sausage rolls have all the rich flavour you like in a sausage roll using lean chicken mince. They’re perfect for party finger food snacks, lazy lunches, and the perfect snack for kids. They’re easy to make and kind of fun too.',
        imageUri:
            'https://images.ctfassets.net/pjshm78m9jt4/292426_header/f4ca7b9a88202b32c668746d52d98560/importedImage292426_header',
        thumbnailUri:
            'https://images.ctfassets.net/pjshm78m9jt4/292426_header/f4ca7b9a88202b32c668746d52d98560/importedImage292426_header',
      ),
      Product(
        articleCode: '1000448',
        shopCode: '1234',
        availableFrom: DateTime.parse("2022-01-01T00:00:00Z"),
        availableUntil: DateTime.parse("2023-05-13T23:59:59Z"),
        eatOutPrice: 5.99,
        eatInPrice: 6.99,
        articleName: 'Classic Burger',
        dayParts: ['Lunch', 'Dinner'],
        internalDescription:
            'Delicious classic burger',
        customerDescription:
            'Savor the flavor with our Classic Burger! Made with the finest ingredients, it\'s a treat for your taste buds. Perfect for lunch or dinner.',
        imageUri:
            'https://d3gqeq5wcctqxw.cloudfront.net/catalogadmin/7e12dbf8-9ba4-4ef1-b75b-df2deac0286f/Smoky-Beef-Bacon-Burgers.jpg',
        thumbnailUri:
            'https://d3gqeq5wcctqxw.cloudfront.net/catalogadmin/7e12dbf8-9ba4-4ef1-b75b-df2deac0286f/Smoky-Beef-Bacon-Burgers.jpg',
      ),
      //can Add more products as needed
    ];
    return Scaffold(
      appBar: CommonAppBar(pageName: 'Greggs'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2.6 / 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductGridItem(product: productList[index]);
            },
          ),
        ),
      ),
    );
  }
}
