import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';

class FireBaseUtils{
  static CollectionReference<Task> getTasksCollection(){
    return FirebaseFirestore.instance.collection(Task.collectionName).withConverter<Task>
      (
        fromFirestore: ((snapshot,object)=>Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,option)=>task.toFireStore()
    );
  }

  static  Future<void> addTaskToFirebase(Task task){
    var taskCollection =getTasksCollection();
    DocumentReference<Task>taskDocRef=taskCollection.doc();
    task.id=taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void>deleteTaskFromFireStore(Task task){
    return getTasksCollection().doc(task.id).delete();
  }
}