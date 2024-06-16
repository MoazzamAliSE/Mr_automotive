import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/res/app_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sell({required ProductModel product}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('PHONENUMBER', product.owner.contact.toString());

    _db
        .collection(AppCollections.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'myProducts': FieldValue.arrayUnion([product.id]),
    });
    await _db
        .collection(AppCollections.productCollection)
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> addToFavourite({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'favouriteProducts': FieldValue.arrayUnion([id])
    });
  }

  Future<void> removeFavourite({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'favouriteProducts': FieldValue.arrayRemove([id])
    });
  }

  Future<void> addToCart({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'myCart': FieldValue.arrayUnion([id])
    });
  }

  Future<void> removeCart({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'myCart': FieldValue.arrayRemove([id])
    });
  }
}
