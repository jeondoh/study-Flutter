import 'package:flutter/material.dart';
import 'package:order_app/common/components/pagination_list_view.dart';
import 'package:order_app/product/model/product_model.dart';
import 'package:order_app/product/provider/product_provider.dart';

import '../component/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return ProductCard.fromProductModel(model: model);
      },
    );
  }
}
