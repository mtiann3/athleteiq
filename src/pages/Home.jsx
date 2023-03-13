import React from "react";
import { Link } from "react-router-dom";

const Home = () => {
  return (
    // background div
    <div className=" flex flex-col items-center w-auto h-screen p-10  m-auto bg-[#46433f]">
      {/* heading/slogan */}
      <h1 className="text-center mb-4 text-4xl font-extrabold leading-none tracking-tight text-[#b52e2b] md:text-5xl lg:text-6xl ">
        "Track Your Progress, Transform Your Body"
      </h1>
      {/* description */}
      <p className="p-10 text-2xl italic font-bold text-center leading-[3rem] text-[#e11624] ">
        For Athletes, made by an Athlete. Track your progress and transform your body with your own personalized
        fitness app. Input your stats and get a custom workout plan made just for you. Reach
        your fitness goals efficiently with progress tracking. Start your
        transformation journey now!
      </p>
      <Link to="/signin" className="items-center">
        <button
          className="text-white bg-black hover:bg-[#b52e2b] h-20 w-38 focus:ring-4 focus:outline-none focus:ring-white font-medium rounded-lg text-med px-5 py-3 text-center inline-flex items-center"
        >
          Continue
          <svg
            aria-hidden="true"
            class="w-5 h-5 ml-2 -mr-1"
            fill="currentColor"
            viewBox="0 0 20 20"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              fill-rule="evenodd"
              d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
              clip-rule="evenodd"
            ></path>
          </svg>
        </button>
      </Link>
    </div>
  );
};

export default Home;
