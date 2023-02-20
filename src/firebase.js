// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import {getFirestore} from "@firebase/firestore"
import { collection, getDocs } from 'firebase/firestore';

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCkpRSQ6O_lxjQLmEkZyYXA_KTkn87H-3A",
  authDomain: "athleteiqmtiann3.firebaseapp.com",
  databaseURL: "https://athleteiqmtiann3-default-rtdb.firebaseio.com",
  projectId: "athleteiqmtiann3",
  storageBucket: "athleteiqmtiann3.appspot.com",
  messagingSenderId: "367397616773",
  appId: "1:367397616773:web:881138c4f131bba33bfdec"
};


// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);

