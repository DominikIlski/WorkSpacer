const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { default: fetch } = require("node-fetch");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
process.env.X_GOOGLE_NEW_FUNCTION_SIGNATURE = true;
admin.initializeApp();
const auth = admin.auth();
exports.proxy = functions.https.onCall((data, context) => {
  const method = data.method;
  const body = data.body ? { data: data.body } : null;
  const route = data.route;
  console.log("data", data);
  console.log("body", body);
  console.log("payload", `https://work-spacer.herokuapp.com/api/${route}?populate=*`, {
    method: method,
    body: body,
    headers: {
      Authorization: `Bearer ${process.env.API_KEY}`,
      ...(body && {"Content-Type": "application/json"})
    },
  });
  return fetch(`https://work-spacer.herokuapp.com/api/${route}?populate=*`, {
    method: method,
    ...(body && {body: JSON.stringify(body)}),
    headers: {
      Authorization: `Bearer ${process.env.API_KEY}`,
      ...(body && {"Content-Type": "application/json"})
    },
  }).then((res) => res.json());
});

exports.createUser = functions.https.onRequest((req, res) => {
  functions.logger.log(req);
  const body = req.body;
  const email = body.email;
  const passwd = body.passwd;
  const isAdmin = body?.isAdmin;
  const strapiId = body.strapiId;
  const name = body?.name;
  return auth
    .createUser({
      email: email,
      emailVerified: true,
      password: passwd,
      displayName: name ?? email.split("@")[0],
      disabled: false,
    })
    .then(function (userRecord) {
      auth.setCustomUserClaims(userRecord.uid, {
        admin: isAdmin,
        strapiId: strapiId,
      });
      res.status(200).send("user created");
      return "done";
    })
    .catch(function (error) {
      functions.logger.log("Error creating new user:", error);
      res.status(500).send(error);
    });
});
