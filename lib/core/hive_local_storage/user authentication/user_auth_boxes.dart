import 'package:hive/hive.dart';
import 'user_authentication_hive.dart';

late Box boxUserAuth;

Future<void> openUserAuthBox() async {
  boxUserAuth = await Hive.openBox<UserAuthentication>('userAuthBox');
}

Future<void> closeUserAuthBox() async {
  await boxUserAuth.close();
}

Future<int> createUserAuthBox(UserAuthentication userAuth) async {
  await openUserAuthBox();
  return await boxUserAuth.add(userAuth);
}