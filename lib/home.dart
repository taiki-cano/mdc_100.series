// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  // Add a variable for Category (104)
  final Category category;
  const HomePage({this.category = Category.all, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add app bar (102)
      // appBar: AppBar(
      //   title: const Text('SHRINE'),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.menu,
      //       semanticLabel: 'menu',
      //     ),
      //     onPressed: () {
      //       print('Menu button');
      //     },
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {
      //         print('Search button');
      //       },
      //       icon: const Icon(Icons.search, semanticLabel: 'search'),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         print('Filter button');
      //       },
      //       icon: const Icon(Icons.tune, semanticLabel: 'filter'),
      //     ),
      //   ],
      // ),
      // Add a grid view (102)
      // Return an AsymmetricView (104)
      body: AsymmetricView(
        // Pass Category variable to AsymmetricView (104)
        products: ProductsRepository.loadProducts(category), //Category.all),
      ),
    );
  }
}

// class BuildGridCards extends StatefulWidget {
//   const BuildGridCards({Key? key}) : super(key: key);
//   @override
//   State<BuildGridCards> createState() => _BuildGridCardsState();
// }
// class _BuildGridCardsState extends State<BuildGridCards> {
//   List<Product> products = ProductsRepository.loadProducts(Category.all);
//   @override
//   void initState() {
//     super.initState();
//     if (products.isEmpty) const <Card>[];
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 2,
//       padding: const EdgeInsets.all(16.0),
//       childAspectRatio: 8.0 / 9.0,
//       children: _buildGridCards(context),
//     );
//   }
//   // Make a collection of cards (102)
//   List<Card> _buildGridCards(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final NumberFormat formatter =
//         NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString());
//     return products.map((product) {
//       return Card(
//           clipBehavior: Clip.antiAlias,
//           elevation: 0.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // AspectRatio(
//               //   aspectRatio: 18.0 / 11.0,
//               //   child: Image.asset(
//               //     product.assetName,
//               //     package: product.assetPackage,
//               //     fit: BoxFit.fitWidth,
//               //   ),
//               // ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Text(
//                       //   product.name,
//                       //   style: theme.textTheme.titleLarge,
//                       //   softWrap: false,
//                       //   overflow: TextOverflow.ellipsis,
//                       //   maxLines: 1,
//                       // ),
//                       // const SizedBox(height: 4.0),
//                       // Text(
//                       //   formatter.format(product.price),
//                       //   style: theme.textTheme.titleSmall,
//                       // ),
//                       Text(product.category.toString()),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ));
//     }).toList();
//   }
// }
