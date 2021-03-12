import 'package:get_it/get_it.dart';
import 'package:learning_tracker/services/auth.dart';
import 'package:learning_tracker/services/todoService.dart';
import 'package:learning_tracker/services/youtubeAPI.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<YoutubeService>(YoutubeService());
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<TodoService>(TodoService());
  // getIt.registerSingleton(instance)
}
