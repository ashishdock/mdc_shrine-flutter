import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SHRINE',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: [
          IconButton(
            onPressed: () => print('Search Button'),
            icon: Icon(
              Icons.search_rounded,
              semanticLabel: 'search',
            ),
          ),
          IconButton(
            onPressed: () => print('Filter button'),
            icon: Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(9.0),
          childAspectRatio: 8.0 / 9.0,
          children: products.isEmpty
              ? [const Card()]
              : products
                  .map((prod) => GridCard(
                        product: prod,
                      ))
                  .toList(),
          // for (var i = 0; i < 10; i++) GridCard(),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class GridCard extends StatelessWidget {
  final Product product;

  const GridCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.titleLarge,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 9.0,
                ),
                Text(
                  formatter.format(product.price),
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
