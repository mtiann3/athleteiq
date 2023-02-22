import React, { useEffect, useState } from "react";
import WeightModel from "../components/WeightModel";
import PlyoModel from "../components/PlyometricModel";
import ListView from "../components/ListView";
import Graph from "../components/Graph";
import { UserAuth } from "../context/AuthContext";
import { useExerciseFetch } from "../hooks/useExerciseFetch";

const Progress = () => {
  const { logOut, user } = UserAuth();

  const [muscle, setMuscle] = useState(() =>
    JSON.parse(localStorage.getItem("triceps"))
  );
  const { data, loading } = useExerciseFetch(
    `https://api.api-ninjas.com/v1/exercises?muscle=${muscle}`
  );

  useEffect(() => {
    localStorage.setItem("muscle", JSON.stringify(muscle));
  }, [muscle]);

  return (
    <div className="w-auto h-screen p-10  m-auto bg-[#46433f]">
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
          <ListView />
          <Graph className="w-max z-0" />
        </div>
        <div>
          <div>
            <h6 class="text-xl font-bold dark:text-white">
              {!data ? "loading..." : data}
            </h6>
            {/* <div>Name : {data.name}</div>
            <div>Email : {data.email}</div>
            <div>Website : {data.website}</div> */}
          </div>
          <div>
            <h5 class="text-lg font-bold dark:text-black">Muscle: {muscle}</h5>
          </div>
          <button
            onClick={() => setMuscle((c) => c)}
            type="button"
            class="py-2.5 px-5 mr-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-full border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
          >
            Enter
          </button>

          <div class="mb-3 pt-0">
            <input
              type="text"
              placeholder="Enter Muscle"
              onChange={(e) => setMuscle(e.target.value)}
              class="px-3 py-3 placeholder-slate-300 text-slate-600 relative bg-white bg-white rounded text-sm border border-slate-300 outline-none focus:outline-none focus:ring w-full"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Progress;
