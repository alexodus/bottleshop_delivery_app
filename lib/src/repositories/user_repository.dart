import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/cart_item_model.dart';
import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  final CollectionReference _shoppingCartsCollection =
      FirebaseFirestore.instance.collection(Constants.categoriesCollection);
  final CollectionReference _favoritesCollection =
      FirebaseFirestore.instance.collection(Constants.favoritesCollection);
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(Constants.usersCollection);

  UserRepository._internal();

  factory UserRepository() => _instance;

  Future<User> getUser(String uid) async {
    final userSnapShot = await _usersCollection.doc(uid).get();
    return userSnapShot.exists ? User.fromMap(userSnapShot.data()) : null;
  }

  Future<void> setUser(User user) async {
    final userDocRef = _usersCollection.doc(user.uid);
    return userDocRef.set(user.toMap(), SetOptions(merge: true));
  }

  Future<List<CartItemModel>> shoppingCart(String uid) =>
      _shoppingCartsCollection
          .doc(uid)
          .snapshots()
          .map((event) => CartItemModel.fromJson(event.data()))
          .toList();
  Stream<CartItemModel> favorites(String uid) => _favoritesCollection
      .doc(uid)
      .snapshots()
      .map((event) => CartItemModel.fromJson(event.data()));
}

final shoppingCartProvider = FutureProvider<List<CartItemModel>>((ref) async {
  final user = await ref.watch(authProvider).currentUser();
  final repo = await ref.watch(userRepositoryProvider).shoppingCart(user.uid);
  return repo;
});

class FavouriteList extends StateNotifier<List<ProductModel>> {
  FavouriteList() : super(const []);

  bool isFavorite(String id) {
    return state.indexWhere((element) => element.uniqueId == id) > -1;
  }

  void addItem(ProductModel item) {
    state = [
      ...state,
      item,
    ];
  }

  void removeItem(ProductModel product) {
    state = state.where((item) => product.uniqueId != item.uniqueId).toList();
  }
}

final favouriteListProvider = StateNotifierProvider((ref) => FavouriteList());
