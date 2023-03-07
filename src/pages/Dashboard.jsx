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
  const [userExercisesArr, setUserExercisesArr] = useState();
  const [showWeightExercises, setShowWeightExercises] = useState(false);
  const [weightData, setWeightData] = useState();
  const handleClick = async () => {
    setShowWeightExercises(!showWeightExercises);

    try {
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const x = docSnap.data().exercises;
      let arrTemp = [];

      for (let i = 0; i < x.length; i++) {
        arrTemp.push(x[i].name);
      }

      console.log(arrTemp);
      setUserExercisesArr(arrTemp);
    } catch (e) {
      console.error("Error updating user: ", e);
    }
  };
  const getShowList = () => {
    return !showWeightExercises ? false : true;
  };
  return (
    <div className="w-20 h-20">
      Dashboard
      <MacronutriPieChart />
      <button
        className="text-white p-5 bg-black hover:bg-[#b52e2b] h-auto w-auto focus:ring-4 focus:outline-none focus:ring-white font-small rounded-lg  px-5 py-5 text-center inline-flex items-center"
        onClick={() => handleClick("Calves")}
      >
        Click to see exercise history
      </button>
      <div class="mb-3 pt-0">
        {/* {getShowList() && <ListView data={userExercisesArr} />}  */}
      </div>
    </div>
  );
};

export default Dashboard;
