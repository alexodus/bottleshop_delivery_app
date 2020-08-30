import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/cart_item_model.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  final FirebaseFirestore _firestoreInstance;
  final _cart = <CartItemModel>[];
  final _wishList = <String>[];

  UserDataService() : _firestoreInstance = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUser(String uid) async {
    return _firestoreInstance
        .collection(Constants.usersCollection)
        .doc(uid)
        .get();
  }

  Future<void> setUser(User user) async {
    return _firestoreInstance
        .collection(Constants.usersCollection)
        .doc(user.uid)
        .set(
          user.toJson(),
          SetOptions(merge: true),
        );
  }

  CollectionReference getFavoriteListFor(String uid) => _firestoreInstance
      .collection(Constants.usersCollection)
      .doc(uid)
      .collection(Constants.favoritesCollection);

  CollectionReference getShoppingCartFor(String uid) {
    return _firestoreInstance
        .collection(Constants.usersCollection)
        .doc(uid)
        .collection(Constants.cartCollection);
  }

  Stream<QuerySnapshot> shoppingCartItemCount(String uid) {
    return getShoppingCartFor(uid)
        .orderBy('documentId', descending: true)
        .limit(1)
        .snapshots();
  }

  Future<void> addProductToCart(CartItemModel product) async {
    _cart.add(product);
  }

  Future<void> removeProductFromCart(String productRef) async {
    _cart.removeWhere((element) => element.productRef == productRef);
  }

  Future<void> addProductToWishList(String productRef) async {
    if (!isProductInWishList(productRef)) {
      _wishList.add(productRef);
    }
  }

  Future<void> removeProductFromWishList(String productRef) async {
    if (isProductInWishList(productRef)) {
      _wishList.remove(productRef);
    }
  }

  bool isProductInWishList(String productRef) => _wishList.contains(productRef);

  bool isProductInCart(String productRef) =>
      _cart.indexWhere((element) => element.productRef == productRef) == 0;
}
