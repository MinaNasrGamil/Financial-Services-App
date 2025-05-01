import 'package:easy_localization/easy_localization.dart';
import 'package:finance_app/constants/enums/status_enum.dart';
import 'package:finance_app/constants/styles/styles.dart';
import 'package:finance_app/logic/cubits/product/product_cubit.dart';
import 'package:finance_app/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().loadProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('our_products'.tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case StatusEnum.loading:
              return const Center(child: CircularProgressIndicator());
            case StatusEnum.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMessage, style: AppStyles.bodyText),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ProductCubit>().loadProducts(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case StatusEnum.success:
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, i) => ProductCard(product: state.products[i]),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
