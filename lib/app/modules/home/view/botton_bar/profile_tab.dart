import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/widgets/app_section_card.dart';
import 'package:uni_match/widgets/profile_basic_info_card.dart';
import 'package:uni_match/widgets/profile_statistics_card.dart';
import 'package:uni_match/widgets/sign_out_button_card.dart';
import 'package:uni_match/widgets/vip_account_card.dart';

class ProfileTab extends StatefulWidget {

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final AppController i18n = Modular.get();

  @override
  void initState() {
    i18n.buscarTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Basic profile info
          ProfileBasicInfoCard(),

          SizedBox(height: 10),

          /// Profile Statistics Card
          ProfileStatisticsCard(),

          SizedBox(height: 10),

          /// Show VIP dialog
          VipAccountCard(),

          SizedBox(height: 10),

          /// App Section Card
          AppSectionCard(),

          SizedBox(height: 20),

          /// Sign out button card
          SignOutButtonCard(),

          SizedBox(height: 5),

        ],
      )
    );
  }
}
