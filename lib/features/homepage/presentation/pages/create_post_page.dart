import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _selectedTags = [];

  final List<String> _availableTags = [
     'depresi', 
     'cinta', 
     'keluarga', 
     'sekolah', 
     'pekerjaan', 
     'teman', 
     'kesehatan mental'
  ];

  bool _isSubmitting = false;

  Future<void> _submitPost() async {
    final user= FirebaseAuth.instance.currentUser;
    if (user == null || _textController.text.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    }); 

    try {
      final userDoc= await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

        final username= userDoc.data()?['username'] ?? 'anon';

        await FirebaseFirestore.instance.collection('posts').add({
          'userId': user.uid,
          'username': username,
          'text': _textController.text.trim(),
          'tags': _selectedTags,
          'timestamp': FieldValue.serverTimestamp(),
          'likes': 0,
          'commentsCount': 0,
          'is_flagged': false,
        });

        if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint('Gagal Possting: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuat curhatan')),
      );
    } finally {
      setState(() {
        _isSubmitting= false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tulis Curhatan'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Tulis isi curhatmu disini...',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 16,),
            Wrap(
              spacing: 8,
              runSpacing: -8,
              children: _availableTags.map((tag) {
                final selected= _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: selected, 
                  onSelected: (isSelected) {
                    setState(() {
                      isSelected
                        ? _selectedTags.add(tag)
                        : _selectedTags.remove(tag);
                    });
                  }
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: _isSubmitting
                ? const CircularProgressIndicator(strokeAlign: 2, color: Colors.white,)
                : const Text('Kirim Curhatan'),
              onPressed: _isSubmitting ? null : _submitPost,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48)
              ),
            )
          ],
        ),
      ),
    );
  }
}