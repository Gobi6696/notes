import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gobinew/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<void> saveNote({String? noteId}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (titleController.text.trim().isEmpty || contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both title and content')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final noteData = {
      'title': titleController.text.trim(),
      'content': contentController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      if (noteId == null) {
        await users.doc(user.uid).collection('notes').add(noteData);
      } else {
        await users.doc(user.uid).collection('notes').doc(noteId).update(noteData);
      }
      Navigator.pop(context); // Close loading dialog
      titleController.clear();
      contentController.clear();
      Navigator.pop(context); // Close note dialog
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving note: $e')),
      );
    }
  }

  // Delete Note
  Future<void> deleteNote(String noteId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await users.doc(user.uid).collection('notes').doc(noteId).delete();
                Navigator.pop(context); // Close confirmation dialog
              } catch (e) {
                Navigator.pop(context); // Close confirmation dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting note: $e')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }


  void showNoteDialog({String? noteId, String? title, String? content}) {
    if (noteId != null) {
      titleController.text = title ?? '';
      contentController.text = content ?? '';
    } else {
      titleController.clear();
      contentController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(noteId == null ? 'Add Note' : 'Edit Note'),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => saveNote(noteId: noteId),
            child: Text(noteId == null ? 'Save' : 'Update'),
          ),
        ],
      ),
    );
  }

  // Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('No user logged in'))
          : SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: users.doc(user.uid).collection('notes').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No notes found'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final note = doc.data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      note['title'] ?? 'No Title',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      note['content'] ?? 'No Content',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => showNoteDialog(
                            noteId: doc.id,
                            title: note['title'],
                            content: note['content'],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: () => deleteNote(doc.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}