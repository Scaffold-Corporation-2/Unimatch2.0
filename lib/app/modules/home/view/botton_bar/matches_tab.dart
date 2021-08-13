import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/api/matches_api.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/widgets/build_title.dart';
import 'package:uni_match/widgets/loading_card.dart';
import 'package:uni_match/widgets/no_data.dart';
import 'package:uni_match/widgets/processing.dart';
import 'package:uni_match/widgets/profile_card.dart';
import 'package:uni_match/widgets/users_grid.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  /// Variables
  final MatchesApi _matchesApi = MatchesApi();
  List<DocumentSnapshot>? _matches;
  AppController _i18n = Modular.get();

  @override
  void initState() {
    super.initState();

    /// Get user matches
    _matchesApi.getMatches().then((matches) {
      if (mounted) setState(() => _matches = matches);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization

    return Column(
      children: [
        /// Header
        BuildTitle(
          svgIconName: 'heart_icon',
          title: _i18n.translate("matches")!,
        ),

        /// Show matches
        Expanded(child: _showMatches()),
      ],
    );
  }

  /// Handle matches result
  Widget _showMatches() {
    /// Check result
    if (_matches == null) {
      return Processing(text: _i18n.translate("loading"));
    } else if (_matches!.isEmpty) {
      /// No match
      return NoData(
        svgName: 'heart_icon', text: _i18n.translate("no_match")!);
    } else {
      /// Load matches
      return UsersGrid(
        itemCount: _matches!.length,
        itemBuilder: (context, index) {
          /// Get match doc
          final DocumentSnapshot match = _matches![index];

          /// Load profile
          return FutureBuilder<DocumentSnapshot>(
              future: UserModel().getUser(match.id),
              builder: (context, snapshot) {
                /// Check result
                if (!snapshot.hasData) return LoadingCard();

                /// Get user object
                final Usuario user = Usuario.fromDocument(snapshot.data!.data() as Map);

                /// Show user card
                return GestureDetector(
                    child: ProfileCard(user: user, page: 'matches'),
                    onTap: () {
                      /// Go to chat screen
                      Modular.to.pushNamed('/chat', arguments: user);
                    });
              });
        },
      );
    }
  }
}
