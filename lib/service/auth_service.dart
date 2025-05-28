import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(
    String firstname,
    String username,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await saveUserData(user.uid, firstname, username, email);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Parol juda kuchsiz.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Bu email allaqachon ro‘yxatdan o‘tgan.');
      }
      throw Exception('Xato yuz berdi: ${e.message}');
    }
  }

  Future<void> saveUserData(
    String uid,
    String firstname,
    String username,
    String email,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'firstname': firstname,
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Xato $e");
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Xato: $e");
      return null;
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> addCarToFirestore(
    String uid,
    String name,
    String carid,
    String cartype,
    String carimage,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cars')
        .add({
          'name': name,
          'carid': carid,
          'cartype': cartype,
          'carimage': carimage,
        });
  }

  Future<void> addCarPark(
    String uid,
    String title,
    String hour,
    String name,
    String place,
    String klm,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('parks')
        .add({
          'title': title,
          'hour': hour,
          'name': name,
          'place': place,
          'klm': klm,
        });
  }
}
