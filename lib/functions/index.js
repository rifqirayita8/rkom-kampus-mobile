import { firestore } from 'firebase-functions';
import { initializeApp, firestore as _firestore } from 'firebase-admin';
initializeApp();

export const incrementCommentsCount = firestore
  .document('comments/{commentId}')
  .onCreate(async (snap, context) => {
    const newComment = snap.data();
    const postId = newComment.postId;

    if (!postId) {
      console.warn("Comment created without postId!");
      return null;
    }

    const postRef = _firestore().collection('posts').doc(postId);

    await postRef.update({
      commentsCount: _firestore.FieldValue.increment(1),
    });

    return null;
  });

export const decrementCommentsCount = firestore
  .document('comments/{commentId}')
  .onDelete(async (snap, context) => {
    const oldComment = snap.data();
    const postId = oldComment.postId;

    if (!postId) return null;

    const postRef = _firestore().collection('posts').doc(postId);
    await postRef.update({
      commentsCount: _firestore.FieldValue.increment(-1),
    });

    return null;
  });

