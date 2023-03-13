import { useContext, createContext, useEffect, useState } from "react";
import NutritionModel from "../components/NutritionModel";
import ListView from "../components/ListView";
import { UserAuth } from "../context/AuthContext";
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
import NutriListView from "../components/NutriListView";
import RemoveNutritionModel from "../components/RemoveNutritionModel";
const Nutrition = () => {
  const { logOut, user } = UserAuth();
  const [dataNames, setDataNames] = useState("");
  const [dataCarbs, setDataCarbs] = useState("");
  const [dataCals, setDataCals] = useState("");
    const [dataProteins, setDataProteins] = useState("");
    const [dataFats, setDataFats] = useState("");
    const [dataServings, setDataServings] = useState("");

  const [showData, setShowData] = useState();

  const handleClick = async () => {
    getCustomFoods();

    setShowData(!showData);
  };
  const getShowData = () => {
    return showData && dataNames !== "";
  };
  const getCustomFoods = async () => {
    try {
      //update user and set exercise name
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const userCustomFoodArr = docSnap.data().customFoods;
      //   console.log(userExercisesArr);
      let arrTempNames = [];
      let arrTempCals = [];
      let arrTempsCarbs = [];
      let arrTempFats = [];
      let arrTempProteins = [];
      let arrTempServings = [];

      for (let i = 0; i < userCustomFoodArr.length; i++) {
        arrTempNames.push(userCustomFoodArr[i].name);
        arrTempCals.push(userCustomFoodArr[i].calories);
        arrTempFats.push(userCustomFoodArr[i].fats);
        arrTempsCarbs.push(userCustomFoodArr[i].carbs);
        arrTempProteins.push(userCustomFoodArr[i].proteins);
        arrTempServings.push(userCustomFoodArr[i].servings);
      }
      setDataNames(arrTempNames);
      setDataCarbs(arrTempsCarbs);
      setDataCals(arrTempCals);
      setDataFats(arrTempFats);
      setDataProteins(arrTempProteins);
      setDataServings(arrTempServings);

    } catch (e) {
      console.error("Error updating user: ", e);
    }
  };

  return (
    <div>
      <NutritionModel />
      <RemoveNutritionModel/>
      <button
        className="bg-blue-200 text-black active:bg-blue-500 
      font-bold px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1"
        type="button"
        onClick={() => handleClick()}
      >
        Add Custom Nutrition Item
      </button>
      <div class="mb-3 pt-0">
        {getShowData() && (
          <NutriListView
            dataNames={dataNames}
            dataCals={dataCals}
            dataCarbs={dataCarbs}
            dataFats={dataFats}
            dataProteins={dataProteins}
            dataServings={dataServings}

          />
        )}
      </div>
    </div>
  );
};

export default Nutrition;
