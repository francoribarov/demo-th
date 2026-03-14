import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';

class ReturnedRentalCard extends StatelessWidget {
  const ReturnedRentalCard({
    required this.rental,
    this.dropOffTicket,
    this.onConfirm,
    this.onReport,
    super.key,
  });

  final RentalRequest rental;
  final RentalDropOffResponse? dropOffTicket;
  final VoidCallback? onConfirm;
  final VoidCallback? onReport;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final rentalRange =
        '${dateFormat.format(rental.startDate)} - ${dateFormat.format(rental.endDate)}';
    final dropOffDate = dropOffTicket != null
        ? dateFormat.format(DateTime.parse(dropOffTicket!.dropOffDate))
        : null;
    final images = dropOffTicket?.images ?? [];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.purple.withValues(alpha: 0.25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: game title + renter + price
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rental.game.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Arrendatario: ${rental.requester.username}',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${rental.totalPrice.round()}',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.gameRust,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.statusReturned.withOpacityValue(0.1),
                        border: Border.all(
                          color: AppColors.statusReturned.withOpacityValue(0.3),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'DEVUELTO',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.statusReturned,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Rental date range
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: AppColors.gameBrown,
                ),
                const SizedBox(width: 4),
                Text(
                  rentalRange,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gameBrown,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Drop-off ticket section
            Row(
              children: [
                const Icon(
                  Icons.assignment_return_outlined,
                  size: 16,
                  color: AppColors.gameRust,
                ),
                const SizedBox(width: 6),
                Text(
                  'Ticket de Devolución',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.gameRust,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (dropOffDate != null) ...[
                  Text(
                    dropOffDate,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onReport,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.report_outlined,
                          size: 18,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Images gallery
            if (images.isEmpty)
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.gameBrown,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sin imágenes',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 100,
                          color: AppColors.background,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.gameRust,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, err) => Container(
                          width: 100,
                          color: AppColors.background,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            color: AppColors.gameBrown,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Action button
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onConfirm,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.primaryForeground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  minimumSize: const Size.fromHeight(44),
                ),
                child: const Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
