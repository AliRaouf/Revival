import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/business_partner_expandable_card.dart';
import 'package:revival/shared/utils.dart';

// ignore: must_be_immutable
class PartnerList extends StatefulWidget {
  final bool isEmpty;
  final String selectedPartnerType;
  final TextEditingController searchController;
  final int length;
  final List<dynamic> filteredBusinessPartners;
  String? expandedPartnerCode;
  final NumberFormat currencyFormatter;
  PartnerList({
    super.key,
    required this.isEmpty,
    required this.selectedPartnerType,
    required this.searchController,
    required this.length,
    required this.filteredBusinessPartners,
    required this.expandedPartnerCode,
    required this.currencyFormatter,
  });

  @override
  State<PartnerList> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);

    if (widget.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 70,
                color: utilities.theme.disabledColor,
              ), // Use utilities's disabled color
              const SizedBox(height: 16),
              Text(
                // Localize the message
                'No Business Partners Found',
                style: utilities.textTheme.titleMedium?.copyWith(
                  color: utilities.textTheme.bodySmall?.color?.withOpacity(0.7),
                ), // Use a slightly less prominent color
                textAlign: TextAlign.center,
              ),
              if (widget.selectedPartnerType != 'All' ||
                  widget.searchController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    // Localize the hint
                    'Try adjusting your search or type filter.',
                    style: utilities.textTheme.bodySmall?.copyWith(
                      color: utilities.textTheme.bodySmall?.color?.withOpacity(
                        0.5,
                      ),
                    ), // Use a lighter color
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: 80.0,
      ),
      itemCount: widget.length,
      itemBuilder: (context, index) {
        final partner = widget.filteredBusinessPartners[index];
        final bool isExpanded = widget.expandedPartnerCode == partner.code;
        return BusinessPartnerExpandableCard(
              partner: partner,
              currencyFormatter: widget.currencyFormatter,
              getBalanceColor:
                  (balance) => utilities.getBalanceColor(context, balance),
              isExpanded: isExpanded,
              onTap: () {
                setState(() {
                  if (widget.expandedPartnerCode == partner.code) {
                    widget.expandedPartnerCode = null;
                  } else {
                    widget.expandedPartnerCode = partner.code;
                  }
                });
              },
            )
            .animate(delay: (100 * (index % 10)).ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOutCubic);
      },
    );
  }
}
