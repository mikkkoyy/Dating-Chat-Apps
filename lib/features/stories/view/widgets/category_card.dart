import 'package:flutter/material.dart';
import 'package:mingleph/features/stories/view/pages/category_page.dart';
import 'package:mingleph/l10n/app_localizations.dart';
import 'package:mingleph/utils/enums/story_category.dart';
import 'package:mingleph/utils/ui_sizes.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.color});

  final StoryCategory category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // CategoryPage fetches its stories from categoryStoriesProvider on build
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => CategoryPage(category: category),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: UiSizes.height_70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiSizes.width_5),
              color: color,
            ),
          ),
          Positioned(
            left: UiSizes.width_16,
            top: UiSizes.height_14,
            child: Text(
              AppLocalizations.of(context)!.storyCategory(category.name),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: UiSizes.size_17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
