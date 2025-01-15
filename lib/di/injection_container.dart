import 'package:get_it/get_it.dart';
import '../../../domain/repository/images/images_repository.dart';
import '../bloc/images_bloc/images_bloc.dart';
import '../data/repository/remote/images_repository_impl.dart';


/// The global service locator
GetIt sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<ImagesRepository>(() => ImagesRepositoryImpl());
  sl.registerFactory(() => ImagesBloc(repository: sl<ImagesRepository>()));
}
