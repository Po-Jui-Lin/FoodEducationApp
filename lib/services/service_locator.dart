
import 'package:food_education_app/auth/login/login_page_logic.dart';
import 'package:food_education_app/auth/signup/signup_page_logic.dart';
import 'package:food_education_app/pages/DetailAlternative/detail_alternative_logic.dart';
import 'package:food_education_app/pages/DetailResult/detailResultScreenLogic.dart';
import 'package:food_education_app/pages/DetailUserrating/components/detail_userrating_logic.dart';
import 'package:get_it/get_it.dart';

import '../auth/auth_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => LoginPageLogic());

  getIt.registerLazySingleton(() => AuthService());

  getIt.registerLazySingleton(() => SignUpPageLogic());

  getIt.registerLazySingleton(() => DetailResultScreenLogic());

  getIt.registerLazySingleton(() => DetailAlternativeLogic());

  getIt.registerLazySingleton(() => DetailUserratingLogic());

}
