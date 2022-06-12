const functions = require('firebase-functions');
const admin = require("firebase-admin");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.proxy = functions.https.onCall((data, context) => {
return '';
});

exports.createUser = functions.https.onRequest((req, res) => {
    console.log(req);
    // const result = await fetch('https://work-spacer.herokuapp.com/api/employees/');
    // admin.auth().createUser({
    //   email: "user@example.com",
    //   emailVerified: false,
    //   phoneNumber: "+11234567890",
    //   password: "secretPassword",
    //   displayName: "John Doe",
    //   photoURL: "http://www.example.com/12345678/photo.png",
    //   disabled: false,
    //   bre
    // })
    //   .then(function(userRecord) {
    //     // See the UserRecord reference doc for the contents of userRecord.
    //     console.log("Successfully created new user:", userRecord.uid);
    //   })
    //   .catch(function(error) {
    //     console.log("Error creating new user:", error);
    //   });
    res.send(req);
});