// const functions = require("firebase-functions");
// const admin = require("firebase-admin");

// admin.initializeApp();
// exports.myFunction = functions.firestore
//     .document("chats/{chatId}/messages/{messageId}")
//     .onCreate((snap, context) => {
//       console.log(snap.data());
//       // eslint-disable-next-line max-len
//       admin.messaging().sendToTopic("messages",
//           {
//             notification: {title: snap.data().userNmae,
//               body: snap.data().text,
//               clickAction: "FLUTTER_NOTIFICATION_CLICK",
//             },
//           });
//     });


