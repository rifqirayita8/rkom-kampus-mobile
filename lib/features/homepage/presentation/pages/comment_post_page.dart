import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';

class CommentPostPage extends StatefulWidget {
  final String postId;
  final String postContent;
  final String username;

  const CommentPostPage({
    super.key, 
    required this.postId, 
    required this.postContent, 
    required this.username
  });

  @override
  State<CommentPostPage> createState() => _CommentPostPageState();
}

class _CommentPostPageState extends State<CommentPostPage> {
  final TextEditingController _commentController = TextEditingController();

  Stream<QuerySnapshot> getCommentsStream() {
    return FirebaseFirestore.instance
      .collection('posts')
      .doc(widget.postId)
      .collection('comments')
      .orderBy('timestamp', descending: false)
      .snapshots();
  }

  Future<void> submitComment() async {
    final user= FirebaseAuth.instance.currentUser;
    if (user == null || _commentController.text.trim().isEmpty) return;

    final userDoc= await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final username= userDoc['username'] ?? 'anon';

    final commentRef= FirebaseFirestore.instance
      .collection('posts')
      .doc(widget.postId)
      .collection('comments');

    await commentRef.add({
      'postId': widget.postId,
      'userId': user.uid,
      'username': username,
      'text': _commentController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({
      'commentsCount': FieldValue.increment(1),
    });

    _commentController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Komentar'
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.username}',
                  style: TextStyle(
                    fontFamily: FontFamily.montserratBold
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.postContent
                ),
                const Divider(height: 24)
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: getCommentsStream(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final comments= snapshot.data?.docs ?? [];

                if (comments.isEmpty) {
                  return const Center(child: Text('Belum ada komentar.'));
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment= comments[index];
                    final timeStamp= comment['timestamp'] as Timestamp?;
                    final formattedTime = timeStamp != null
                      ? DateFormat('dd MM yyyy • HH:mm').format(timeStamp.toDate())
                      : '';

                      return ListTile(
                        title: Text('@${comment['username'] ?? 'anon'}'),
                        subtitle: Text(comment['text'] ?? ''),
                        trailing: Text(
                          formattedTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      );
                  }
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis Komentar...',
                    ),
                  )
                ),
                IconButton(
                  onPressed: submitComment,
                  icon: const Icon(Icons.send)

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}