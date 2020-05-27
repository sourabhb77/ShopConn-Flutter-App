const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.newUser= functions.auth.user().onCreate((user)=>
{
    let email=user.email?user.email:"";
    let name=user.name? name: "";
    let data ={
        "email": email,
        "name": name,
        "userId": user.uid,
    }

    return admin.firestore().collection("users").doc(`${user.uid}`).set(data,{merege:true})
    .then((Response)=>
    {
        console.log(Response);
        return Response;
    }).catch((err)=>
    {
        console.log("Error: ",err);
        return err;
    })
})
