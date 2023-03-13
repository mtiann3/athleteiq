import ListView from "./ListView";
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
const NutriListView = ({
  dataNames,
  dataCals,
  dataCarbs,
  dataFats,
  dataProteins,
  dataServings,
}) => {
  const { logOut, user } = UserAuth();
    console.log(dataNames,dataProteins)
  const componentArray = [];
  console.log(dataNames);
  const handleClick = async(name, cals, carbs, fats, proteins, servings) => {
    //add custom food to db
    const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const userFoodArr = docSnap.data().nutrition;

    let arrTemp = [];
    for (let i = 0; i < userFoodArr.length; i++) {
        arrTemp.push(userFoodArr[i]);
      }
    arrTemp.push({
        name: name,
        carbs: carbs,
        fats: fats,
        proteins: proteins,
        servings: servings,
        calories: cals,
      });
    try {
      updateDoc(doc(db, "users", user.uid), {
        nutrition: arrTemp,
      });
    } catch (e) {
      console.log("Error updating user: ", e);
    }
  };
  // console.log(data)
  const getItem = () => {
    for (var i = 0; i < dataNames.length; i++) {
      const name = dataNames[i];
      const carbs = dataCarbs[i];
      const cals = dataCals[i];
      const fats = dataFats[i];
      const proteins = dataProteins[i];
      const servings = dataServings[i];

      componentArray.push(
        <li
          onClick={() =>
            handleClick(name, cals, carbs, fats, proteins, servings)
          }
          class="p-3 hover:bg-blue-600 hover:text-blue-200"
        >
          {name}
          {" Cal: "}
          {cals}
          {" Carb: "}
          {carbs}
          {" Fat: "}
          {fats}
          {" Protein: "}
          {proteins}
          {" Servings: "}
          {servings}
        </li>
      );
    }
    return componentArray;
  };

  return (
    <div class="w-full bg-white rounded-lg shadow-lg ">
      <ul class="divide-y-2 divide-gray-100 inline">{getItem()}</ul>
    </div>
  );
  // return state;
};
export default NutriListView;
