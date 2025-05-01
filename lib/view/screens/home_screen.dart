import 'package:easy_localization/easy_localization.dart';
import 'package:finance_app/routes.dart';
import 'package:finance_app/view/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double totalContentHeight =
                constraints.maxHeight * 0.6 + 4 * 60.0;

            return CustomScrollView(
              physics: totalContentHeight < constraints.maxHeight
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset('assets/finease.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                if (totalContentHeight < constraints.maxHeight)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    fillOverscroll: true,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        ..._buildAllButtons(context),
                      ],
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      _buildAllButtons(context),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildAllButtons(BuildContext context) {
    return [
      MenuButton(
        label: 'contact_us'.tr(),
        onPressed: () => Navigator.pushNamed(context, Routes.contact),
      ),
      MenuButton(
        label: 'our_products'.tr(),
        onPressed: () => Navigator.pushNamed(context, Routes.products),
      ),
      MenuButton(
        label: 'submit_complaint'.tr(),
        onPressed: () => Navigator.pushNamed(context, Routes.complaint),
      ),
      MenuButton(
        label: 'about_company'.tr(),
        onPressed: () => Navigator.pushNamed(context, Routes.about),
      ),
    ];
  }
}
