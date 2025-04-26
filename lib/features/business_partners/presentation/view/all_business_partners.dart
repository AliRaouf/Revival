import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/business_partners/domain/entities/business_partner.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/business_partner_appbar.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/partner_list.dart';
import 'package:revival/shared/utils.dart';

class AllBusinessPartnerWowListPage extends StatefulWidget {
  const AllBusinessPartnerWowListPage({super.key});
  @override
  State<AllBusinessPartnerWowListPage> createState() =>
      _AllBusinessPartnerWowListPageState();
}

class _AllBusinessPartnerWowListPageState
    extends State<AllBusinessPartnerWowListPage> {
  List<BusinessPartner> _allBusinessPartners = [];
  List<BusinessPartner> filteredBusinessPartners = [];
  final TextEditingController _searchController = TextEditingController();
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'EGP',
  );
  final List<String> _partnerTypeOptions = ['All', 'Customers', 'Vendors'];
  String? expandedPartnerCode;
  final String _selectedPartnerType = 'All';
  @override
  void initState() {
    super.initState();
    Utilities utilities = Utilities(context);
    _allBusinessPartners = utilities.allBusinessPartners;
    _filterPartners();
    _searchController.addListener(_filterPartners);
  }

  void _filterPartners() {
    final query = _searchController.text.toLowerCase();
    final typeFilter = _selectedPartnerType;

    setState(() {
      List<BusinessPartner> tempFiltered = _allBusinessPartners;

      if (typeFilter == 'Customers') {
        tempFiltered =
            tempFiltered.where((p) => p.partnerType == 'Customer').toList();
      } else if (typeFilter == 'Vendors') {
        tempFiltered =
            tempFiltered.where((p) => p.partnerType == 'Vendor').toList();
      }
      if (query.isNotEmpty) {
        tempFiltered =
            tempFiltered.where((partner) {
              final nameLower = partner.name.toLowerCase();
              final codeLower = partner.code.toLowerCase();
              return nameLower.contains(query) || codeLower.contains(query);
            }).toList();
      }
      filteredBusinessPartners = tempFiltered;
      expandedPartnerCode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchController.text.isNotEmpty;
    final Utilities utilities = Utilities(context);
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: BusinessPartnerAppbar(
        selectedPartnerType: _selectedPartnerType,
        filterPartners: _filterPartners,
        searchController: _searchController,
        partnerTypeOptions:
            _partnerTypeOptions.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
        isSearching: isSearching,
      ),

      body: PartnerList(
        isEmpty: filteredBusinessPartners.isEmpty,
        selectedPartnerType: _selectedPartnerType,
        searchController: _searchController,
        length: filteredBusinessPartners.length,
        filteredBusinessPartners: filteredBusinessPartners,
        expandedPartnerCode: expandedPartnerCode,
        currencyFormatter: currencyFormatter,
      ), // Pass context to access utilities in helper
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/business_partners/new_business_partner');
        },
        backgroundColor: utilities.colorScheme.secondary,
        foregroundColor: utilities.colorScheme.onSecondary,
        child: const Icon(Icons.add),
      ).animate().scale(
        delay: 500.ms,
        duration: 400.ms,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPartners);
    _searchController.dispose();
    super.dispose();
  }
}
