import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_todo/firebase_utils/model.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
        fromFirestore: (snapshot, options) =>
            Task.fromFireStore(snapshot.data()!),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();
    DocumentReference<Task> docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTaskFromFirestore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTask(Task task) {
    return getTasksCollection()
        .doc(task.id)
        .update(
          task.toFireStore(),
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
