const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
exports.myFunction = functions.firestore
    .document("users/{userPhone}/friends/{friendPhone}/chats/{message}")
    .onCreate((snap, context) => {
      console.log(snap.data());
      // eslint-disable-next-line max-len
      admin.messaging().sendToTopic("/chats/",
          {
            notification: {title: snap.data().userNmae,
              body: snap.data().text,
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          });
    });


