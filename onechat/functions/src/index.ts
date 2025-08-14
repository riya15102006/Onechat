import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

export const scheduleDailyMatch = functions.pubsub
  .schedule('every day 16:30') // 10 PM IST = 16:30 UTC depending on DST; adjust as needed
  .timeZone('Asia/Kolkata')
  .onRun(async () => {
    // TODO: Implement real matching algorithm based on location, age, mood
    // For now, log stub
    console.log('Running daily match scheduler');
    return null;
  });

export const expireChats = functions.pubsub
  .schedule('every 5 minutes')
  .onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const expiring = await db
      .collection('matches')
      .where('status', 'in', ['active', 'pending'])
      .where('expiresAt', '<=', now)
      .get();

    const batch = db.batch();
    for (const doc of expiring.docs) {
      const data = doc.data();
      const bothLiked = Boolean(data.userALiked && data.userBLiked);
      batch.update(doc.ref, { status: bothLiked ? 'matched' : 'expired' });
      // TODO: If not both liked, delete messages subcollection
      // TODO: Send FCM notifications about expiry outcome
    }
    await batch.commit();
    console.log(`Expired ${expiring.size} chats`);
    return null;
  });

export { oneLastMessageWebhook } from './purchase';