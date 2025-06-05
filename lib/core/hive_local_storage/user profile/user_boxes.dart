import 'package:hive/hive.dart';
import 'user_information_hive.dart';

late Box boxUser;

// Initialize the user box (call this before any CRUD operation)
Future<Box<User>> openUserBox() async {
  return await Hive.openBox<User>('userBox');
}

Future<void> closeUserBox() async {
  return await Hive.close();
}

// CREATE: Add a new user
dynamic createUser(User user) async {
  await openUserBox();
  return await boxUser.add(user);
}

// READ: Get a user by key
Future<User?> getUser(int key) async {
  final box = await openUserBox();
  return box.get(key);
}

// READ: Get all users
Future<List<User>> getAllUsers() async {
  final box = await openUserBox();
  return box.values.toList();
}

// UPDATE: Update a user by key
Future<void> updateUser(int key, User updatedUser) async {
  final box = await openUserBox();
  await box.put(key, updatedUser);
}

// DELETE: Delete a user by key
Future<void> deleteUser(int key) async {
  final box = await openUserBox();
  await box.delete(key);
}
