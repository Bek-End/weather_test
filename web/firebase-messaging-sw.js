importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: 'AIzaSyCUFeyP2SQ5AXIXCf5vDsH3GvyzaYfSQok',
  appId: '1:848462754126:web:78ca5bf3a685d735806e1f',
  messagingSenderId: '848462754126',
  projectId: 'itfox-test',
  authDomain: 'itfox-test.firebaseapp.com',
  storageBucket: 'itfox-test.appspot.com',
  measurementId: 'G-7LCS5RYYX5',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});