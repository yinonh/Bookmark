import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia/service/trivia_provider.dart';

import 'package:trivia/models/trivia_categories.dart';

part 'categories_screen_manager.freezed.dart';
part 'categories_screen_manager.g.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required TriviaCategories categories,
  }) = _CategoriesState;
}

@riverpod
class CategoriesScreenManager extends _$CategoriesScreenManager {
  @override
  Future<CategoriesState> build() async {
    final trivia = ref.read(triviaProvider.notifier);
    return CategoriesState(categories: await trivia.getCategories());
  }

  void resetAchievements() {
    ref.read(triviaProvider.notifier).resetAchievements();
  }

  void setCategory(int categoryId) {
    final trivia = ref.read(triviaProvider.notifier);
    trivia.setCategory(categoryId);
  }
}
