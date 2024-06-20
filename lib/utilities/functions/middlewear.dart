import '../../views/home/home_screen.dart';
import '../../views/signin/signin.dart';
import '../shared_preference.dart';
import '../singleton.dart';
import 'navigation.dart';

rootMiddlewear() async {
  final bool? isLoggedIn =
      await locator<SharedPreferenceService>().getBool(key: "loggedIn");
  if (isLoggedIn == true) {
    pushReplaced(screen: const HomeScreen());
  } else {
    pushReplaced(screen: const SigninScreen());
  }
}
