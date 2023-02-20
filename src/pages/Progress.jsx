import React from "react";
import WeightModel from "../components/WeightModel";
import PlyoModel from "../components/PlyometricModel";
import ListView from "../components/ListView";
import Graph from "../components/Graph";
import { UserAuth } from '../context/AuthContext';


const Progress = () => {
  const { logOut, user } = UserAuth();

  // api for exercises
  const getExercise = () => {
    const headers = { "X-Api-Key": "2kLFNSocLGSrUDczknoQww==bdwR08KZB6MeqpXL" };
    fetch("https://api.api-ninjas.com/v1/exercises?muscle=triceps", { headers })
      .then((response) => response.json())
      .then((response) => console.log(response));
    console.log(user?.email)
  };
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
        <button onClick={getExercise}>Exercise API</button>
      </div>
    </div>
  );
};

export default Progress;
