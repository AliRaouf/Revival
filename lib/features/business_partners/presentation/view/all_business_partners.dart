import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/business_partners/data/models/business_partner/datum.dart';
import 'package:revival/features/business_partners/presentation/cubit/business_partner_cubit.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/business_partner_appbar.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/partner_list.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/business_partners_search.dart';

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
  String _searchQuery = '';
  String? expandedPartnerCode;
  final String _selectedPartnerType = 'All';
  @override
  void initState() {
    context.read<BusinessPartnerCubit>().getBusinessPartners();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      if (_searchQuery.isEmpty) {
        filteredBusinessPartners = _allBusinessPartners;
      } else {
        filteredBusinessPartners =
            _allBusinessPartners?.where((partner) {
              final name = partner.cardName?.toLowerCase() ?? '';
              final code = partner.cardCode?.toLowerCase() ?? '';
              final query = _searchQuery.toLowerCase();
              return name.contains(query) || code.contains(query);
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: BusinessPartnerAppbar(),

      body: BlocListener<BusinessPartnerCubit, BusinessPartnerState>(
        listener: (context, state) {
          if (state is SinglePartnerSuccess) {
            context.push('/business_partners/single_business_partner');
          }
        },
        child: BlocBuilder<BusinessPartnerCubit, BusinessPartnerState>(
          builder: (context, state) {
            if (state is BusinessPartnerLoading) {
              return Center(child: SpinKitWave(color: primaryColor, size: 40));
            } else if (state is BusinessPartnerError) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            } else if (state is BusinessPartnerSuccess) {
              _allBusinessPartners = state.businessPartners.data;
              // Only update filtered list if not searching
              if (_searchQuery.isEmpty) {
                filteredBusinessPartners = _allBusinessPartners;
              }
            }

            return Column(
              children: [
                businessPartnersSearch(
                  context,
                  _searchController,
                  _searchQuery,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      PartnerList(
                        isEmpty: filteredBusinessPartners?.isEmpty,
                        selectedPartnerType: _selectedPartnerType,
                        searchController: _searchController,
                        length: filteredBusinessPartners?.length,
                        filteredBusinessPartners: filteredBusinessPartners,
                        expandedPartnerCode: expandedPartnerCode,
                      ),
                      BlocBuilder<BusinessPartnerCubit, BusinessPartnerState>(
                        builder: (context, state) {
                          if (state is SinglePartnerLoading) {
                            return Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Center(
                                child: SpinKitWave(
                                  color: primaryColor,
                                  size: 40,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
