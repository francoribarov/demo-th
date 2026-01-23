import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/my_games_view.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/rental_requests_view.dart';

class MyPublicationsPage extends StatelessWidget {
  const MyPublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Publicaciones'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gameBrown.withOpacityValue(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  tabs: const [
                    Tab(text: 'Solicitudes'),
                    Tab(text: 'Publicaciones'),
                  ],
                  indicator: BoxDecoration(
                    color: AppColors.gameRust,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.gameBrown,
                  dividerColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  RentalRequestsView(),
                  MyGamesView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
