import 'package:brewly/domain/entities/country_coffee.dart';
import 'package:brewly/domain/repositories/explore_tab_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'explore_tab_state.dart';

@injectable
class ExploreTabCubit extends Cubit<ExploreTabState> {
  final ExploreTabRepo explore;
  ExploreTabCubit({required this.explore}) : super(ExploreTabInitial());

  Future<void> loadExploreData() async {
    try {
      emit(ExploreTabLoading());
      final countiresCoffees = await explore.allCountriesCoffees();
      emit(ExploreTabLoaded(countryCoffee: countiresCoffees));
    } catch (e) {
      emit(ExploreTabError(message: e.toString()));
    }
  }
}
