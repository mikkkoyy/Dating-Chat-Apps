import 'package:flutter/material.dart';
import 'package:mingleph/l10n/app_localizations.dart';
import 'package:mingleph/shared/model/follower_user_model.dart';
import 'package:mingleph/features/stories/view/widgets/filtered_list_tile.dart';

class FollowersScreen extends StatelessWidget {
  final List<FollowerUserModel> followers;
  const FollowersScreen({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.followers)),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final follower = followers[index];
          return FilteredListTile(
            isStory: false,
            user: follower.toResonateUser(),
          );
        },
      ),
    );
  }
}
