import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService<T> {
  String collection;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final T Function(String, Map<String, dynamic>) fromSnapshot;
  final Map<String, dynamic> Function(T) toMap;

  DatabaseService(this.collection, {this.fromSnapshot, this.toMap});

  FirebaseFirestore get db => _db;

  Future<T> getSingle(String id) async {
    var snap = await _db.collection(collection).doc(id).get();
    if (!snap.exists) return null;
    return fromSnapshot(snap.id, snap.data());
  }

  Stream<T> streamSingle(String id) {
    return _db
        .collection(collection)
        .doc(id)
        .snapshots()
        .map((snap) => snap.exists ? fromSnapshot(snap.id, snap.data()) : null);
  }

  Stream<List<T>> streamList() {
    var ref = _db.collection(collection);
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => fromSnapshot(doc.id, doc.data())).toList());
  }

  Future<List<T>> getQueryList({
    List<OrderBy> orderBy,
    List<QueryArgs> args,
    int limit,
    dynamic startAfter,
    dynamic startAt,
    dynamic endAt,
    dynamic endBefore,
  }) async {
    CollectionReference collref = _db.collection(collection);
    Query ref;
    if (args != null) {
      for (final arg in args) {
        if (ref == null) {
          ref = collref.where(
            arg.key,
            isEqualTo: arg.isEqualTo,
            isGreaterThan: arg.isGreaterThan,
            isGreaterThanOrEqualTo: arg.isGreaterThanOrEqualTo,
            isLessThan: arg.isLessThan,
            isLessThanOrEqualTo: arg.isLessThanOrEqualTo,
            isNull: arg.isNull,
            arrayContains: arg.arrayContains,
            arrayContainsAny: arg.arrayContainsAny,
            whereIn: arg.whereIn,
          );
        } else {
          ref = ref.where(
            arg.key,
            isEqualTo: arg.isEqualTo,
            isGreaterThan: arg.isGreaterThan,
            isGreaterThanOrEqualTo: arg.isGreaterThanOrEqualTo,
            isLessThan: arg.isLessThan,
            isLessThanOrEqualTo: arg.isLessThanOrEqualTo,
            isNull: arg.isNull,
            arrayContains: arg.arrayContains,
            arrayContainsAny: arg.arrayContainsAny,
            whereIn: arg.whereIn,
          );
        }
      }
    }
    if (orderBy != null) {
      orderBy.forEach((order) {
        if (ref == null)
          ref = collref.orderBy(order.field, descending: order.descending);
        else
          ref = ref.orderBy(order.field, descending: order.descending);
      });
    }
    if (limit != null) {
      if (ref == null)
        ref = collref.limit(limit);
      else
        ref = ref.limit(limit);
    }
    if (startAfter != null && orderBy != null) {
      ref = ref.startAfter([startAfter]);
    }
    if (startAt != null && orderBy != null) {
      ref = ref.startAt([startAt]);
    }
    if (endAt != null && orderBy != null) {
      ref = ref.endAt([endAt]);
    }
    if (endBefore != null && orderBy != null) {
      ref = ref.endBefore([endBefore]);
    }
    QuerySnapshot query;
    if (ref != null) {
      query = await ref.get();
    } else {
      query = await collref.get();
    }
    return query.docs.map((doc) => fromSnapshot(doc.id, doc.data())).toList();
  }

  Stream<List<T>> streamQueryList({
    List<OrderBy> orderBy,
    List<QueryArgs> args,
    int limit,
    dynamic startAfter,
    dynamic startAt,
    dynamic endBefore,
    dynamic endAt,
  }) {
    CollectionReference collref = _db.collection(collection);
    Query ref;
    if (orderBy != null) {
      orderBy.forEach((order) {
        if (ref == null)
          ref = collref.orderBy(order.field, descending: order.descending);
        else
          ref = ref.orderBy(order.field, descending: order.descending);
      });
    }
    if (args != null) {
      for (final arg in args) {
        if (ref == null) {
          ref = collref.where(
            arg.key,
            isEqualTo: arg.isEqualTo,
            isGreaterThan: arg.isGreaterThan,
            isGreaterThanOrEqualTo: arg.isGreaterThanOrEqualTo,
            isLessThan: arg.isLessThan,
            isLessThanOrEqualTo: arg.isLessThanOrEqualTo,
            isNull: arg.isNull,
            arrayContains: arg.arrayContains,
            arrayContainsAny: arg.arrayContainsAny,
            whereIn: arg.whereIn,
          );
        } else {
          ref = ref.where(
            arg.key,
            isEqualTo: arg.isEqualTo,
            isGreaterThan: arg.isGreaterThan,
            isGreaterThanOrEqualTo: arg.isGreaterThanOrEqualTo,
            isLessThan: arg.isLessThan,
            isLessThanOrEqualTo: arg.isLessThanOrEqualTo,
            isNull: arg.isNull,
            arrayContains: arg.arrayContains,
            arrayContainsAny: arg.arrayContainsAny,
            whereIn: arg.whereIn,
          );
        }
      }
    }
    if (limit != null) {
      if (ref == null) {
        ref = collref.limit(limit);
      } else {
        ref = ref.limit(limit);
      }
    }
    if (startAfter != null && orderBy != null) {
      ref = ref.startAfter([startAfter]);
    }
    if (startAt != null && orderBy != null) {
      ref = ref.startAt([startAt]);
    }
    if (endAt != null && orderBy != null) {
      ref = ref.endAt([endAt]);
    }
    if (endBefore != null && orderBy != null) {
      ref = ref.endBefore([endBefore]);
    }
    if (ref != null) {
      return ref.snapshots().map((snap) =>
          snap.docs.map((doc) => fromSnapshot(doc.id, doc.data())).toList());
    } else {
      return collref.snapshots().map((snap) =>
          snap.docs.map((doc) => fromSnapshot(doc.id, doc.data())).toList());
    }
  }

  Future<List<T>> getListFromTo(String field, DateTime from, DateTime to,
      {List<QueryArgs> args = const []}) async {
    var ref = _db.collection(collection).orderBy(field);
    for (final arg in args) {
      ref = ref.where(
        arg.key,
        isEqualTo: arg.isEqualTo,
        isGreaterThan: arg.isGreaterThan,
        isGreaterThanOrEqualTo: arg.isGreaterThanOrEqualTo,
        isLessThan: arg.isLessThan,
        isLessThanOrEqualTo: arg.isLessThanOrEqualTo,
        isNull: arg.isNull,
        arrayContains: arg.arrayContains,
        arrayContainsAny: arg.arrayContainsAny,
        whereIn: arg.whereIn,
      );
    }
    QuerySnapshot query = await ref.startAt([from]).endAt([to]).get();
    return query.docs.map((doc) => fromSnapshot(doc.id, doc.data())).toList();
  }

  Stream<List<T>> streamListFromTo(String field, DateTime from, DateTime to,
      {List<QueryArgs> args = const []}) {
    var ref = _db.collection(collection).orderBy(field, descending: true);
    for (final arg in args) {
      ref = ref.where(
        arg.key,
        isEqualTo: arg.isEqualTo,
        isGreaterThan: arg.isGreaterThan,
        isGreaterThanOrEqualTo: arg.isGreaterThanOrEqualTo,
        isLessThan: arg.isLessThan,
        isLessThanOrEqualTo: arg.isLessThanOrEqualTo,
        isNull: arg.isNull,
        arrayContains: arg.arrayContains,
        arrayContainsAny: arg.arrayContainsAny,
        whereIn: arg.whereIn,
      );
    }
    var query = ref.startAfter([to]).endAt([from]).snapshots();
    return query.map((snap) =>
        snap.docs.map((doc) => fromSnapshot(doc.id, doc.data())).toList());
  }

  Future<dynamic> create(Map<String, dynamic> data, {String id}) {
    if (id != null) {
      return _db.collection(collection).doc(id).set(data);
    } else {
      return _db.collection(collection).add(data);
    }
  }

  Future<void> updateData(String id, Map<String, dynamic> data) {
    return _db.collection(collection).doc(id).update(data);
  }

  Future<void> removeItem(String id) {
    return _db.collection(collection).doc(id).delete();
  }
}

class QueryArgs {
  final dynamic key;
  final dynamic isEqualTo;
  final dynamic isLessThan;
  final dynamic isLessThanOrEqualTo;
  final dynamic isGreaterThanOrEqualTo;
  final dynamic isGreaterThan;
  final dynamic arrayContains;
  final List<dynamic> arrayContainsAny;
  final List<dynamic> whereIn;
  final bool isNull;

  QueryArgs(
    this.key, {
    this.isEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.isNull,
    this.isGreaterThanOrEqualTo,
  });
}

class OrderBy {
  final String field;
  final bool descending;

  OrderBy(this.field, {this.descending = false});
}
