import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class databaseServices{
  String uid;
  databaseServices({required this.uid});
//-------------------authentication services------------------------------------//
  FirebaseAuth auth = FirebaseAuth.instance;

  //Registration
  Future signInWIthUSernameAndPasssword(String userName, String password) async {
   try{
     User user = (await auth.createUserWithEmailAndPassword(email: userName, password: password)).user!;
     if(user != null){
       return true;
     }
   }on FirebaseAuthException catch(e){
     print(e);
   }
  }

  // Login
  Future signinWithUsernameAndPassword(String userName, String password) async {
    try{
      User user = (await auth.signInWithEmailAndPassword(
          email: userName, password: password))
          .user!;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    }on FirebaseAuthException catch(e){
      print(e);
    }
  }
//-------------------------------------MAIN PART--------------------------------------------------//
  CollectionReference ownerCollection = FirebaseFirestore.instance.collection('owners');
  CollectionReference propertyCollection = FirebaseFirestore.instance.collection('property');

  //registering owners
  Future registerOwner(String ownerName, String userId, String numberOfProperties) async{
    DocumentReference ownerReference = await ownerCollection.add({
      "name": ownerName,
      "ownerId": "",
      "propertiesList": [],
    });

    await ownerReference.update({
      "ownerId": ownerReference.id,
    });
  }

  //creating a property
  Future createProperty(String propertyName, String owner, String propertyType, String price, String size, String numberOfBeds) async {
    DocumentReference propertyReference = await ownerCollection.add({
      "propertyName": propertyType,
      "propertyType": propertyName,
      "propertyId": "",
      "owner": owner,
      "price": price,
      "size": size,
      "numberOfBeds": numberOfBeds,
    });

    await propertyReference.update({
      "propertyId": propertyReference.id,
    });

    //updating owner collection by adding property they created
    DocumentReference ownerReference = await ownerCollection.doc(uid);
    await ownerReference.update({
      "propertiesList": FieldValue.arrayUnion(["${propertyReference.id}_$propertyName"]),
    });
  }
}
