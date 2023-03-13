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
export const NutritionModel = () => {
  const { logOut, user } = UserAuth();

  const [showModal, setShowModal] = useState(false);
  const [name, setName] = useState("");
  const [carbs, setCarbs] = useState("");
  const [fats, setFats] = useState("");
  const [proteins, setProteins] = useState("");
  const [servings, setServings] = useState("");
  const [calories, setCalories] = useState("");

  const [state, setState] = useState({
    name: null,
    carbs: null,
    fats: null,
    proteins: null,
    servings: null,
    calories: null,
  });
  const updateCalories =  () => {
     setCalories(
      (parseInt(proteins) * 4 + parseInt(carbs) * 4 + parseInt(fats) * 9) *
        parseInt(servings)
    );
    console.log(
      (parseInt(proteins) * 4 + parseInt(carbs) * 4 + parseInt(fats) * 9) *
        parseInt(servings)
    );
  };
  const handleNameChange = (event) => {
    setName(event.target.value);
    updateCalories();
  };
  const handleCarbsChange = (event) => {
    setCarbs(event.target.value);
    updateCalories();
  };
  const handleFatsChange = (event) => {
    setFats(event.target.value);
    updateCalories();
  };
  const handleProteinsChange = (event) => {
    setProteins(event.target.value);
    updateCalories();
  };
  const handleServingsChange = (event) => {
    setServings(event.target.value);
    updateCalories();
  };
  const handleClick = async () => {
    setShowModal(false);
    setState({
      name: name,
      carbs: carbs,
      fats: fats,
      proteins: proteins,
      servings: servings,
      calories: calories,
    });
    // console.log(user?.displayName);
    //add to list of completed exercises in db.

    try {
      //update user and set exercise name
      console.log(user.uid);
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);
      const userExercisesArr = docSnap.data().customFoods;
      console.log(userExercisesArr);
      let arrTemp = [];

      for (let i = 0; i < userExercisesArr.length; i++) {
        arrTemp.push(userExercisesArr[i]);
      }

      console.log(userExercisesArr);

      arrTemp.push({
        name: name,
        carbs: carbs,
        fats: fats,
        proteins: proteins,
        servings: servings,
        calories: calories,
      });

      updateDoc(doc(db, "users", user.uid), {
        customFoods: arrTemp,
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
        Create Nutrition Item
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
                      Food Name
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="name"
                      name="name"
                      onChange={handleNameChange}
                      //   value={state.name}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Carbohydrates
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="carbs"
                      name="carbs"
                      onChange={handleCarbsChange}
                      //   value={state.carbs}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Fats
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="fats"
                      name="fats"
                      onChange={handleFatsChange}
                      //   value={state.fats}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Protein
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="proteins"
                      name="proteins"
                      onChange={handleProteinsChange}
                      //   value={state.proteins}
                    />
                    <label className="block text-black text-sm font-bold mb-1">
                      Serving Count
                    </label>
                    <input
                      className="shadow appearance-none border rounded w-full py-2 px-1 text-black"
                      type="text"
                      id="servings"
                      name="servings"
                      onChange={handleServingsChange}
                      //   value={state.servings}
                    />
                  </form>
                </div>
                <div className="flex items-center justify-end p-6 border-t border-solid border-blueGray-200 rounded-b">
                  <button
                    className="text-red-500 background-transparent font-bold uppercase px-6 py-2 text-sm outline-none focus:outline-none mr-1 mb-1"
                    type="button"
                    onClick={() => setShowModal(false)}
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
};

export default NutritionModel;
