import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/features/business_partners/data/models/business_partner/datum.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/business_partner_card.dart';
import 'package:revival/shared/utils.dart';

// ignore: must_be_immutable
class PartnerList extends StatefulWidget {
  final bool? isEmpty;
  final String? selectedPartnerType;
  final TextEditingController? searchController;
  final int? length;
  final List<Datum>? filteredBusinessPartners;
  String? expandedPartnerCode;
  PartnerList({
    super.key,
    required this.isEmpty,
    required this.selectedPartnerType,
    required this.searchController,
    required this.length,
    required this.filteredBusinessPartners,
    required this.expandedPartnerCode,
  });

  @override
  State<PartnerList> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);

    if (widget.isEmpty!) {
      return _buildEmptyState(utilities);
    }

    return _buildPartnerList(utilities);
  }

  Widget _buildEmptyState(Utilities utilities) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty State Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    utilities.colorScheme.primary.withOpacity(0.1),
                    utilities.colorScheme.primary.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: utilities.colorScheme.primary.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 60,
                color: utilities.colorScheme.primary.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),

            // Empty State Title
            Text(
              'No Business Partners Found',
              style: utilities.textTheme.titleLarge?.copyWith(
                color: utilities.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Empty State Description
            Text(
              widget.searchController?.text.isNotEmpty == true
                  ? 'No partners match your search criteria. Try adjusting your search terms.'
                  : 'Get started by adding your first business partner to the system.',
              style: utilities.textTheme.bodyMedium?.copyWith(
                color: utilities.textTheme.bodySmall?.color?.withOpacity(0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Action Button
            if (widget.searchController?.text.isNotEmpty == true)
              ElevatedButton.icon(
                icon: const Icon(Icons.clear_rounded, size: 18),
                label: const Text('Clear Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: utilities.colorScheme.primary,
                  foregroundColor: utilities.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  widget.searchController?.clear();
                  setState(() {});
                },
              )
            else
              ElevatedButton.icon(
                icon: const Icon(Icons.add_business_rounded, size: 18),
                label: const Text('Add Partner'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: utilities.colorScheme.secondary,
                  foregroundColor: utilities.colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Navigate to add partner screen
                },
              ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: Offset(0, 0.2));
  }

  Widget _buildPartnerList(Utilities utilities) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: 80.0,
      ),
      itemCount: widget.length,
      itemBuilder: (context, index) {
        final partner = widget.filteredBusinessPartners?[index] ?? Datum();
        return BusinessPartnerCard(
              partner: partner,
              currencyFormatter: NumberFormat.currency(
                locale: 'en_US',
                symbol: partner.currency ?? "EGP",
              ),
              getBalanceColor:
                  (balance) => utilities.getBalanceColor(context, balance),
            )
            .animate(delay: (100 * (index % 10)).ms)
            .fadeIn(duration: 500.ms)
            .slide(
              begin: Offset(0, 0.1),
              duration: 400.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}
