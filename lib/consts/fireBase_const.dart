import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

// collections

const usersCollection = "users";
const emartcategories = "categories";
const emartproductList = "products";
const emartproductCart = "carts";
const emartchats = "chats";
const emartmessages = "messages";
const emartorders = "orders";
