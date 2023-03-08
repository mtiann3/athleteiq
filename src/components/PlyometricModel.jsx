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
  update,
  updateDoc,
  getDocs,
  query,
  where,
  addCollection,
  setDoc,
} from "firebase/firestore";
import { UserAuth } from "../context/AuthContext";

export const PlyoModel = () => {
  const [showModal, setShowModal] = useState(false);
  const { logOut, user } = UserAuth();

  const [name, setName] = useState("");
  const [time, setTime] = useState("");
  const [dist, setDist] = useState("");
  const [date, setDate] = useState("");

  const [state, setState] = useState({
    name: null,
    time: null,
    dist: null,
    date: null,
  });
  const handleNameChange = (event) => {
    setName(event.target.value);
  };
  const handleDistChange = (event) => {
    setDist(event.target.value);
  };
  const handleTimeChange = (event) => {
    setTime(event.target.value);
  };
  const handleDateChange = (event) => {
    setDate(event.target.value);
  };

  const handleClick = async () => {
    setShowModal(false);
    setState({
      name: name,
      time: time,
      dist: dist,
      date: date,
    });
    console.log("hello");
    // console.log(user?.displayName);
    //add to list of completed exercises in db.

    try {
      //update user and set exercise name
      console.log(user.uid);
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const userExercisesArr = docSnap.data().plyoExercises;
      console.log(userExercisesArr);
      let arrTemp = [];

      for (let i = 0; i < userExercisesArr.length; i++) {
        arrTemp.push(userExercisesArr[i]);
      }

      console.log(userExercisesArr);

      arrTemp.push({
        name: name,
        time: time,
        dist: dist,
        date: date,
      });
      console.log(arrTemp);
      updateDoc(doc(db, "users", user.uid), {
        plyoExercises: arrTemp,
      });
    } catch (e) {
      console.error("Error updating user: ", e);
    }
  };
  return (
    <>
      <button
        className="bg-blue-200 text-black active:bg-blue-500 
      font-bold px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1"
        type="button"
        onClick={() => setShowModal(true)}
      >
        Add Plyometric Exercise
      </button>
      {showModal ? (
        <>
          <div className="flex justify-center items-center overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none">
            <div className="relative w-auto my-6 mx-auto max-w-3xl">
              <div className="border-0 rounded-lg shadow-lg relative flex flex-col w-full bg-white outline-none focus:outline-none">
                <div className="flex items-start justify-between p-5 border-b border-solid border-gray-300 rounded-t ">
                  <h3 className="text-3xl font=semibold">Enter Info</h3>
                  <button
                    className="bg-transparent border-0 text-black float-right"
                    onClick={() => setShowModal(false)}
                  >
                    <span className="text-black opacity-7 h-6 w-6 text-xl block bg-gray-400 py-0 rounded-full">
                      x
                    </span>
                  </button>
                </div>
                <div className="relative p-6 flex-auto">
                  <form className="bg-gray-200 shadow-md rounded px-8 pt-6 pb-8 w-full">
                    <label className="block text-black text-sm font-bold mb-1">
                      Exercise Name
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="name"
                      name="name"
                      onChange={handleNameChange}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Time (If necessary)
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="time"
                      name="time"
                      onChange={handleTimeChange}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Distance (Height or Length)
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="dist"
                      name="dist"
                      onChange={handleDistChange}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Date(XX-XX-XXXX)
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="date"
                      name="date"
                      onChange={handleDateChange}
                    />
                  </form>
                </div>
                <div className="flex items-center justify-end p-6 border-t border-solid border-blueGray-200 rounded-b">
                  <button
                    className="text-red-500 background-transparent font-bold uppercase px-6 py-2 text-sm outline-none focus:outline-none mr-1 mb-1"
                    type="button"
                    onClick={() => handleClick()}
                  >
                    Close
                  </button>
                  <button
                    className="text-white bg-yellow-500 active:bg-yellow-700 font-bold uppercase text-sm px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1"
                    type="button"
                    onClick={() => handleClick()}
                  >
                    Submit
                  </button>
                </div>
              </div>
            </div>
          </div>
        </>
      ) : null}
    </>
  );
  return state;
};
