import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const db = admin.firestore();

export const oneLastMessageWebhook = functions.https.onRequest(async (req, res) => {
  // TODO: Verify signature with Stripe/Razorpay accordingly
  try {
    const { uid } = req.body; // validate
    if (!uid) {
      res.status(400).send('uid required');
      return;
    }
    const ref = db.collection('users').doc(uid);
    await db.runTransaction(async (tx) => {
      const doc = await tx.get(ref);
      const credits = (doc.get('oneLastMessageCredits') as number | undefined) ?? 0;
      tx.set(ref, { oneLastMessageCredits: credits + 1 }, { merge: true });
    });
    res.status(200).send('ok');
  } catch (e) {
    console.error(e);
    res.status(500).send('error');
  }
});