# Firebase Setup

1. Create a Firebase project.
2. Enable Authentication providers:
   - Phone
   - Google
3. Create Firestore database in production mode.
4. Create Storage bucket.
5. Configure Cloud Messaging (APNs for iOS, VAPID for web if needed).
6. Run FlutterFire:
   - `dart pub global activate flutterfire_cli`
   - `flutterfire configure` inside the project root

## Firestore Structure
- `users/{uid}`: UserProfile document
- `matches/{matchId}`: OneMatch document
  - `messages/{messageId}`: ChatMessage documents

## Example Security Rules (simplified, tighten for production)
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read: if request.auth != null && request.auth.uid == uid;
      allow write: if request.auth != null && request.auth.uid == uid;
    }

    match /matches/{matchId} {
      allow read, write: if request.auth != null; // TODO restrict to participants
      match /messages/{messageId} {
        allow read, write: if request.auth != null; // TODO restrict to participants
      }
    }
  }
}
```

## Storage Rules (simplified)
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /voice/{uid}/{allPaths=**} {
      allow read: if request.auth != null && request.auth.uid == uid;
      allow write: if request.auth != null && request.auth.uid == uid;
    }
  }
}
```