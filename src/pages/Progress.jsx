import React, { useEffect, useState } from "react";
import PlyoModel from "../components/PlyometricModel";
import ListView from "../components/ListView";
import Graph from "../components/Graph";
import { UserAuth } from "../context/AuthContext";
import { useExerciseFetch } from "../hooks/useExerciseFetch";
import { WeightModel } from "../components/WeightModel";

const Progress = () => {
  const { logOut, user } = UserAuth();
  const [showData, setShowData] = useState();
  const [currentMuscle, setCurrentMuscle] = useState();

  const getShowList = () => {
    return !filteredData ? false : true;
  };
  const handleClick = (muscleEntered) => {
    if (!(currentMuscle === muscleEntered)) {
      setMuscle(muscleEntered);
      setShowData(!showData);
      setCurrentMuscle(muscleEntered);
    }
  };

  // const { ListView, loading } = ListView(

  // );
  const [muscle, setMuscle] = useState(() => localStorage.getItem("triceps"));
  const { data, loading, filteredData } = useExerciseFetch(
    `https://api.api-ninjas.com/v1/exercises?muscle=${muscle}`,
    "name"
  );

  //toggles vuew for listview with data
  // function handleExitViewExercise() {
  //   setShowData(false);
  //   console.log("HELLO")
  //   // showData = !showData
  //   // console.log(showData)
  // };

  useEffect(() => {
    localStorage.setItem("muscle", JSON.stringify(muscle));
  }, [muscle]);

  return (
    <div className="w-auto h-auto p-10  m-auto bg-[#46433f]">
      <div className="p-10">
        <h1 class="mb-4  text-center text-[#ffffff] bg-[#b52e2b] text-4xl p-5 font-extrabold leading-none tracking-tight  md:text-5xl lg:text-6xl ">
          {user?.displayName}'s Progress
        </h1>
        <div className="align-center grid grid-cols-3 gap-1 place-items-start w-screen">
          <WeightModel />
          <PlyoModel />
          <h1 class="mb-4  text-center text-[#ffffff] bg-[#b52e2b] text-xl p-2 font-bold leading-none tracking-tight  ">
            My Exercises
          </h1>
          <div class="w-auto bg-white rounded-lg  shadow-lg ">
            <ul class=" grid grid-cols-4 gap-4 p-5 divide-y-2 divide-gray-100">
              <li
                onClick={() => handleClick("Abdominals")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Abdominals
              </li>
              <li
                onClick={() => handleClick("Abductors")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Abductors
              </li>
              <li
                onClick={() => handleClick("Adductors")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Adductors
              </li>
              <li
                onClick={() => handleClick("Biceps")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Biceps
              </li>
              <li
                onClick={() => handleClick("Calves")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Calves
              </li>
              <li
                onClick={() => handleClick("Chest")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Chest
              </li>
              <li
                onClick={() => handleClick("Forearms")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Forearms
              </li>
              <li
                onClick={() => handleClick("Glutes")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Glutes
              </li>
              <li
                onClick={() => handleClick("Hamstrings")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Hamstrings
              </li>
              <li
                onClick={() => handleClick("Lats")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Lats
              </li>
              <li
                onClick={() => handleClick("lower_back")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Lower Back
              </li>
              <li
                onClick={() => handleClick("middle_back")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Middle Back
              </li>
              <li
                onClick={() => handleClick("Neck")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Neck
              </li>
              <li
                onClick={() => handleClick("Quadriceps")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Quadriceps
              </li>
              <li
                onClick={() => handleClick("Traps")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Traps
              </li>
              <li
                onClick={() => handleClick("Triceps")}
                class="p-3 hover:bg-blue-600 hover:text-blue-200"
              >
                Triceps
              </li>
            </ul>
          </div>
        </div>
        <div>
          <div>
            {/* <h6 class="text-xl font-bold dark:text-white">
              {!filteredData ? "loading..." : filteredData}
            </h6> */}
          </div>
          <div class="mb-3 pt-0">
            {/* <button onClick={() => handleClick2()}>Click me</button> */}
            {getShowList() && (
              <ListView data={!filteredData ? null : filteredData} />
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Progress;
