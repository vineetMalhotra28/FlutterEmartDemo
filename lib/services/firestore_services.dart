import 'package:emart_app/consts/consts.dart';

class firestoreServices {
  static getUser(uid) {
    // return firestore.collection(usersCollection).doc(uid).get();
    // // .where('id', isEqualTo: uid)
    // // .snapshots();
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getCategories() {
    // return firestore.collection(usersCollection).doc(uid).get();
    // // .where('id', isEqualTo: uid)
    // // .snapshots();
    return firestore.collection(emartcategories).snapshots();
  }

  static getProductList(category_id) {
    // return firestore.collection(usersCollection).doc(uid).get();
    // // .where('id', isEqualTo: uid)
    // // .snapshots();
    return firestore
        .collection(emartproductList)
        .where('category_id', isEqualTo: category_id)
        .snapshots();
  }

  static getProductDetails(productid) {
    // print(product_id);
    return firestore
        .collection(emartproductList)
        .where('category_id', isEqualTo: productid)
        .snapshots();
  }

  static getUserCart(uid) {
    // print(product_id);
    return firestore
        .collection(emartproductCart)
        .where('user_id', isEqualTo: uid)
        .snapshots();
  }

  static getChatMessage(docId) {
    return firestore
        .collection(emartchats)
        .doc(docId)
        .collection(emartmessages)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getUserWishlistt(uid) {
    // print(product_id);
    return firestore
        .collection(emartproductList)
        .where('product_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getUserOrders(uid) {
    // print(product_id);
    return firestore
        .collection(emartorders)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getUserMessages(uid) {
    // print(product_id);
    return firestore
        .collection(emartchats)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getUserOrderDetails(id) {
    // print(product_id);
    return firestore
        .collection(emartorders)
        .doc(id)
        // .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(emartproductList)
        .where('is_featured', isEqualTo: true)
        // .where('order_by', isEqualTo: currentUser!.uid)
        .get();
  }

  static getSearchProduct(str) {
    return firestore
        .collection(emartproductList)
        .where('product_name', isLessThanOrEqualTo: str)
        // .where('order_by', isEqualTo: currentUser!.uid)
        .get();
  }
//   Future<DocumentSnapshot> getUserOrderDetails(id) async {
// // var firebaseUser = await FirebaseAuth.instance.currentUser();
//     return await FirebaseFirestore.instance.collection("orders").doc(id).get();
//   }
}
