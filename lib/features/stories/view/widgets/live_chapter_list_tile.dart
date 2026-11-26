import 'package:flutter/material.dart';
import 'package:mingleph/features/stories/model/live_chapter_model.dart';
import 'package:mingleph/l10n/app_localizations.dart';
import 'package:mingleph/utils/ui_sizes.dart';
import 'package:mingleph/shared/widgets/secondary_list_card.dart';

class LiveChapterListTile extends StatelessWidget {
  const LiveChapterListTile({super.key, required this.chapter});

  final LiveChapterModel chapter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SecondaryListCard(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: UiSizes.height_4,
          horizontal: UiSizes.width_5,
        ),
        leading: Icon(Icons.play_circle_outline, color: colorScheme.error),
        title: Text(
          chapter.chapterTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontSize: UiSizes.size_17,
          ),
        ),
        subtitle: Text(
          chapter.chapterDescription,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: UiSizes.size_12,
          ),
        ),
        trailing: Text(AppLocalizations.of(context)!.live),
      ),
    );
  }
}
