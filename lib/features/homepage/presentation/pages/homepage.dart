import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rkom_kampus/features/homepage/presentation/pages/create_post_page.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';
import 'package:rkom_kampus/utils/colors.dart';
import 'package:rkom_kampus/utils/routes.dart';

import 'comment_post_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Stream<QuerySnapshot> getPostsStream() {
    return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('timestamp', descending: true)
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Beranda Curhat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getPostsStream(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tidak ada curhatan saat ini.'));
          }

          final posts= snapshot.data!.docs;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post= posts[index];
              final timestamp = post['timestamp'] as Timestamp?;
              final formattedTime = timestamp != null
                ? DateFormat('dd MM yyyy • HH:mm').format(timestamp.toDate())
                : 'waktu tidak tersedia';
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentPostPage(
                        postId: post.id,
                        postContent: post['text'] ?? '',
                        username: post['username'] ?? 'anon',
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@${post['username'] ?? 'anon'}',
                          style: TextStyle(
                            fontFamily: FontFamily.montserratBold,
                            fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          post['text'] ?? '',
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: (post['tags'] as List<dynamic>? ?? [])
                            .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor: Colors.blue.shade100.withValues(alpha: 0.5),
                              labelStyle: const TextStyle(
                                fontSize: 12
                              ),
                            )).toList(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.favorite, size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                Text('${post['likes'] ?? 0}'),
                                const SizedBox(width: 12),
                                Icon(Icons.comment, size: 16),
                                const SizedBox(width: 4),
                                Text('${post['commentsCount'] ?? 0}'),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const CreatePostPage()
            )
          );
        },
        icon: const Icon(Icons.add), 
        label: const Text('Buat Curhatan')
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        onTap: (index) async {
          if (index == 1) {
            await FirebaseAuth.instance.signOut();
            // Handle logout action
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.landingPage);
            }
          }
        },
      ),
    );
  }
}