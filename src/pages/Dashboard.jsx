import React, { useState } from "react";
import MacronutriPieChart from "../components/MacronutriPieChart";
import ListView from "../components/ListView";
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
import { auth, db } from "../firebase";

const Dashboard = () => {
  const { logOut, user } = UserAuth();
  const [userPlyoExercisesArr, setUserPlyoExercisesArr] = useState("");
  const [userWeightExercisesArr, setUserWeightExercisesArr] = useState("");
  const [showWeightExercises, setShowWeightExercises] = useState(false);
  const [showWeightExercises2, setShowWeightExercises2] = useState(false);

  const [weightData, setWeightData] = useState();
  const handleClick = async () => {
    setShowWeightExercises(!showWeightExercises);

    try {
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const x = docSnap.data().weightExercises;
      let arrTemp = [];

      for (let i = 0; i < x.length; i++) {
        arrTemp.push(x[i].name);
      }


      setUserWeightExercisesArr(arrTemp);


    } catch (e) {
      console.error("Error updating user: ", e);
    }

  };
  const handleClick2 = async () => {
    setShowWeightExercises2(!showWeightExercises2);

    try {
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const x = docSnap.data().plyoExercises;
      let arrTemp = [];

      for (let i = 0; i < x.length; i++) {
        arrTemp.push(x[i].name);
      }


      setUserPlyoExercisesArr(arrTemp);


    } catch (e) {
      console.error("Error updating user: ", e);
    }

  };
  const getShowList = () => {
    return !showWeightExercises ? false : true;
  };
  const getShowList2 = () => {
    return !showWeightExercises2 ? false : true;
  };
  return (
    <div className="w-20 h-20">
      Dashboard
      <MacronutriPieChart />
      <button
        className="text-white p-5 bg-black hover:bg-[#b52e2b] h-auto w-auto focus:ring-4 focus:outline-none focus:ring-white font-small rounded-lg  px-5 py-5 text-center inline-flex items-center"
        onClick={() => handleClick()}
      >
        Click to see Weight exercise history
      </button>
      <div class="mb-3 pt-0">
        {getShowList() && <ListView data={userWeightExercisesArr} />} 
      </div>
      <button
        className="text-white p-5 bg-black hover:bg-[#b52e2b] h-auto w-auto focus:ring-4 focus:outline-none focus:ring-white font-small rounded-lg  px-5 py-5 text-center inline-flex items-center"
        onClick={() => handleClick2()}
      >
        Click to see Plyometric exercise history
      </button>
      <div class="mb-3 pt-0">
        {getShowList2() && <ListView data={userPlyoExercisesArr} />} 
      </div>
    </div>
  );
};

export default Dashboard;
