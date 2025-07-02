import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/business_partners/data/models/business_partner/datum.dart';
import 'package:revival/features/business_partners/presentation/cubit/business_partner_cubit.dart';
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
  List<Datum>? _allBusinessPartners = [];
  List<Datum>? filteredBusinessPartners = [];
  final TextEditingController _searchController = TextEditingController();
  String? expandedPartnerCode;
  final String _selectedPartnerType = 'All';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: BusinessPartnerAppbar(),

      body: BlocBuilder<BusinessPartnerCubit, BusinessPartnerState>(
        builder: (context, state) {
          if (state is BusinessPartnerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BusinessPartnerError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          } else if (state is BusinessPartnerSuccess) {
            _allBusinessPartners = state.businessPartners.data;
            filteredBusinessPartners = _allBusinessPartners;
          }
          return PartnerList(
            isEmpty: filteredBusinessPartners?.isEmpty,
            selectedPartnerType: _selectedPartnerType,
            searchController: _searchController,
            length: filteredBusinessPartners?.length,
            filteredBusinessPartners: filteredBusinessPartners,
            expandedPartnerCode: expandedPartnerCode,
          );
        },
      ), // Pass context to access utilities in helper
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.push('/business_partners/new_business_partner');
      //   },
      //   backgroundColor: utilities.colorScheme.secondary,
      //   foregroundColor: utilities.colorScheme.onSecondary,
      //   child: const Icon(Icons.add),
      // ).animate().scale(
      //   delay: 500.ms,
      //   duration: 400.ms,
      //   curve: Curves.elasticOut,
      // ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
