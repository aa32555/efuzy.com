
firebase.initializeApp({
  apiKey: 'AIzaSyBSj1HfHPGifQPlFGpNwti2H0D0ujd_oLM',
  authDomain: 'hairsalonsystems.firebaseapp.com',
  databaseURL: 'https://hairsalonsystems.firebaseio.com',
  projectId: 'hairsalonsystems',
  storageBucket: 'hairsalonsystems.appspot.com',
  messagingSenderId: '934151319547',
  appId: '1:934151319547:web:8e841841c0521f8158655e',
  measurementId: 'G-69D41DVSYC'
})

const messaging = firebase.messaging()

messaging.setBackgroundMessageHandler(function (payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload)
  // Customize notification here
  const notificationTitle = 'Background Message Title'
  const notificationOptions = {
    body: 'Background Message body.',
    icon: '/firebase-logo.png'
  }

  return self.registration.showNotification(notificationTitle,
    notificationOptions)
})
