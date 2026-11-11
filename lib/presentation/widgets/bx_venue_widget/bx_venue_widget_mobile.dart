// File: lib/presentation/widgets/bx_venue_widget/bx_venue_widget_mobile.dart
// Architecture: Presentation Layer - Venue Shell
// Purpose: Mobile shell — header + scrollable content (info / address / map / facilities)

import 'package:demo_app/presentation/bloc/bx_venue_controller/bx_venue_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/widgets/bx_venue_address_card.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/widgets/bx_venue_facilities_card.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/widgets/bx_venue_header.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/widgets/bx_venue_info_card.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/widgets/bx_venue_map_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxVenueWidgetMobile extends StatelessWidget {
  const BxVenueWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BxVenueHeader(
              onBack: () => Navigator.of(context).pop(),
              onNavigate: () => context.read<BxVenueControllerBloc>().add(
                BxVenueNavigateRequested(),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Scrollable body
          Expanded(
            child: BlocBuilder<BxVenueControllerBloc, BxVenueControllerState>(
              builder: (context, state) {
                // --- Loading ---
                if (state.status == BxVenueStatus.initial ||
                    state.status == BxVenueStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                // --- Error ---
                if (state.status == BxVenueStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          state.errorMessage ?? 'Something went wrong',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16.h),
                        TextButton(
                          onPressed: () => context
                              .read<BxVenueControllerBloc>()
                              .add(BxVenueLoadRequested()),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // --- Success ---
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BxVenueInfoCard(
                        venueName: state.venueName,
                        venueDate: state.venueDate,
                      ),
                      SizedBox(height: 16.h),
                      BxVenueAddressCard(
                        label: state.venueAddressLabel,
                        address: state.venueAddress,
                      ),
                      SizedBox(height: 16.h),
                      BxVenueMapPreview(
                        label: state.mapPreviewLabel,
                        onTap: () => context.read<BxVenueControllerBloc>().add(
                          BxVenueMapTapped(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      BxVenueFacilitiesCard(facilities: state.facilities),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
