import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/business_partners/data/models/single_business_partner/data.dart';
import 'package:revival/features/business_partners/presentation/cubit/business_partner_cubit.dart';
import 'package:revival/shared/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:easy_localization/easy_localization.dart';

class SingleBusinessPartnerPage extends StatefulWidget {
  const SingleBusinessPartnerPage({super.key});

  @override
  State<SingleBusinessPartnerPage> createState() =>
      _SingleBusinessPartnerPageState();
}

class _SingleBusinessPartnerPageState extends State<SingleBusinessPartnerPage> {
  @override
  Widget build(BuildContext context) {
    Utilities utilities = Utilities(context);

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Business Partner Details".tr())
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.2, duration: 300.ms, curve: Curves.easeOut),
        backgroundColor: utilities.colorScheme.primary,
        foregroundColor: utilities.colorScheme.onPrimary,
        elevation: 2.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener<BusinessPartnerCubit, BusinessPartnerState>(
        listener: (context, state) {
          // Handle any state changes if needed
        },
        child: BlocBuilder<BusinessPartnerCubit, BusinessPartnerState>(
          builder: (context, state) {
            if (state is SinglePartnerLoading) {
              return Center(child: SpinKitWave(color: primaryColor, size: 40));
            } else if (state is SinglePartnerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: errorColor),
                    const SizedBox(height: 16),
                    Text(
                      'Error',
                      style: kTextTheme.titleLarge?.copyWith(color: errorColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: mediumTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Retry will be handled by the parent widget
                        context.pop();
                      },
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            } else if (state is SinglePartnerSuccess) {
              final partnerData = state.businessPartner.data;
              if (partnerData == null) {
                return const Center(child: Text('No partner data available'));
              }
              return _buildPartnerDetails(partnerData, utilities);
            }

            return const Center(child: Text('No partner selected'));
          },
        ),
      ),
    );
  }

  Widget _buildPartnerDetails(Data partnerData, Utilities utilities) {
    final formatCurrency = NumberFormat.currency(
      locale: 'en_EG', // Or context.locale.toString()
      symbol: '', // Leave empty if your translation handles the symbol
      decimalDigits: 2,
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card with Partner Name and Code
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.business,
                          size: 32,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partnerData.cardName ?? 'N/A',
                              style: kTextTheme.headlineSmall?.copyWith(
                                color: darkTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Code: {cardCode}'.tr(
                                namedArgs: {
                                  'cardCode': partnerData.cardCode ?? 'N/A',
                                },
                              ),
                              style: kTextTheme.bodyMedium?.copyWith(
                                color: mediumTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildStatusChip(partnerData.cardType ?? 'N/A'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Contact Information Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.contact_phone, color: primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Contact Information'.tr(),
                        style: kTextTheme.titleLarge?.copyWith(
                          color: darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    'Phone'.tr(),
                    "0${partnerData.phone1 ?? ''}",
                    Icons.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    'Address'.tr(),
                    partnerData.address ?? 'N/A',
                    Icons.location_on,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Financial Information Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Financial Information'.tr(),
                        style: kTextTheme.titleLarge?.copyWith(
                          color: darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    'Currency'.tr(),
                    partnerData.currency ?? 'N/A',
                    Icons.attach_money,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    'Current Balance'.tr(),
                    '{currentBalance} {currency}'.tr(
                      namedArgs: {
                        'currentBalance': formatCurrency.format(
                          partnerData.currentBalance ?? 0,
                        ),
                        'currency': partnerData.currency ?? '',
                      },
                    ),
                    Icons.account_balance,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    'Payment Terms'.tr(),
                    partnerData.payTermsGrpCode?.toString() ?? 'N/A',
                    Icons.payment,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Business Information Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.business_center, color: primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Business Information'.tr(),
                        style: kTextTheme.titleLarge?.copyWith(
                          color: darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    'Group'.tr(),
                    partnerData.groupName ?? 'N/A',
                    Icons.group,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    'Price List'.tr(),
                    partnerData.priceListName ?? 'N/A',
                    Icons.price_check,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      () =>
                          launchUrlString("tel://0${partnerData.phone1 ?? ''}"),
                  icon: const Icon(Icons.phone),
                  label: Text('Call'.tr()),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      () =>
                          launchUrlString("sms://0${partnerData.phone1 ?? ''}"),
                  icon: const Icon(Icons.message),
                  label: Text('Message'.tr()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'customer':
        chipColor = successColor.withOpacity(0.1);
        textColor = successColor;
        break;
      case 'vendor':
        chipColor = secondaryColor.withOpacity(0.1);
        textColor = secondaryColor;
        break;
      default:
        chipColor = mediumTextColor.withOpacity(0.1);
        textColor = mediumTextColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: kTextTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: mediumTextColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: kTextTheme.bodySmall?.copyWith(
                  color: mediumTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: kTextTheme.bodyMedium?.copyWith(
                  color: darkTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
