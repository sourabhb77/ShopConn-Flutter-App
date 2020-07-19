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

exports.NewRequest = functions.firestore.document('request/{requestId}').onCreate(async (data, context)=>{
    
    let id = data.data().requestedId; //Ownder of book , send FCM notification to him

    let idToSend = data.data().requesterId;  //Person who wants to but the book get his details like name and image url

    let requesterDeatail = await admin.firestore().collection("users").doc(`${idToSend}`).get(); //get the details
    let personData = requesterDeatail.data();
    let snapDoc = await admin.firestore().collection("users").doc(`${id}`).get();
    let ownerData =  snapDoc.data();

    console.log("Request Sender Name : " ,personData.name ,);
    console.log("Owner name : ", ownerData.name);
    let payload =
    {
        "notification" : {
        "body" : `${personData.name } has sent you a request!`,
        "title" : "You have a new Request",
        "content_available" : "true",
        "priority" : "high"
        },
        "data": {
         "click_action": "FLUTTER_NOTIFICATION_CLICK",
        
        "body": "great match!",
        "image" : `${personData.imageUrl}`,
        "title" : "Portugal vs. Denmark",
        "content_available" : "true",
        "priority" : "high"
        }
    }
    let token = ownerData.FCM_token
    console.log("FCM Token " ,token);
    return admin.messaging().sendToDevice(token, payload).then((Result)=> console.log("Result : " , Result))
    .catch(err => console.log("error  : ",err));
})
