import { useContext, createContext, useEffect, useState } from "react";
import {
  GoogleAuthProvider,
  signInWithPopup,
  signInWithRedirect,
  signOut,
  onAuthStateChanged,
} from "firebase/auth";
import { auth, db } from "../firebase";
import {
  collection,
  addDoc,
  getDoc,
  doc,
  getDocs,
  query,
  where,
} from "firebase/firestore";

const AuthContext = createContext();

export const AuthContextProvider = ({ children }) => {
  const [user, setUser] = useState({});
  const { users, setUsers } = useState([]);

  const googleSignIn = () => {
    const provider = new GoogleAuthProvider();
    // signInWithPopup(auth, provider);
    signInWithRedirect(auth, provider);
  };

  const logOut = () => {
    signOut(auth);
  };

  function isEmpty(str) {
    return !str || str.length === 0;
  }

  // Get a list of users from your database
  //make this check if there is a user with same email already so there areny duplicate acoounts.
  // Get a list of cities from your database

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, async (currentUser) => {
      setUser(currentUser);

      //add user to db
      //prints all users in users collection yuhhhhhhh less goo code works finally
      const q = query(collection(db, "users"));

      const querySnapshot = await getDocs(q);
      const arr = [];
      querySnapshot.forEach((doc) => {
        //goes through all of the registered accounts in db.
        //if account with email exists, do not add.
        arr.push(doc.data().email);
      });
      if (!arr.includes(currentUser.email)) {
        try {
          const docRef = await addDoc(collection(db, "users"), {
            name: currentUser.displayName,
            email: currentUser.email,
          });
          console.log("Document written with ID: ", docRef.id);
        } catch (e) {
          console.error("Error adding document: ", e);
        }
        console.log("User", currentUser);
      }else{
        // console.log("User already exists")
      }
    });
    return () => {
      unsubscribe();
    };
  }, []);

  return (
    <AuthContext.Provider value={{ googleSignIn, logOut, user }}>
      {children}
    </AuthContext.Provider>
  );
};

export const UserAuth = () => {
  return useContext(AuthContext);
};
