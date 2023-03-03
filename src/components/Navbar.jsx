import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { UserAuth } from "../context/AuthContext";
import { FaBars, FaTimes } from "react-icons/fa";
import { useNavigate } from "react-router-dom";

const Navbar = () => {
  const { user, logOut, googleSignIn } = UserAuth();
  const [nav, setNav] = useState(false);
  const loggedIn = user != null;

  const handleClick = () => setNav(!nav);
  // console.log(loggedIn);
  //user !=null will be true if logged in and false if not
  const navigate = useNavigate();
  useEffect(()=>{
    // console.log("mounted")
  }, [])
  const handleSignOut = async () => {
    try {
      await logOut();
      //go to home screen
      navigate("/")
    } catch (error) {
      console.log(error);
    }
  };
  const displayNav = () => {
    if (loggedIn) {
      return !nav;
    }
    return false;
  };
  
  return (
    <div className="flex justify-between bg-[#1a161a]  w-full p-4 ">
      <div onClick={handleClick} className="  z-10 cursor-pointer">
        {(() => {
          if (loggedIn) {
            if (!nav) {
              return <FaBars className="fill-white" size={32} />;
            } else {
              return <FaTimes className="fill-white" size={32} />;
            }
          }
        })()}
      </div>{" "}
      <h1 class="mb-4  content-center text-3xl font-extrabold text-gray-900 dark:text-white md:text-5xl lg:text-6xl">
        <span class="text-transparent bg-clip-text bg-gradient-to-r to-[#b52e2b] from-[#ffffff]">
          AthleteIQ
        </span>{" "}
      </h1>
      {/* TAB MENU */}
      <ul
        className={
          !nav
            ? "hidden "
            : "absolute top-0 left-0 w-full h-screen bg-[#1a161a] flex flex-col justify-center items-center text-white"
        }
      >
        <li className="py-6 text-4xl">
          <Link
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            to="dashboard"
            smooth={true}
            duration={500}
          >
            Dashboard
          </Link>
        </li>
        <li className="py-6 text-4xl">
          <Link
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            to="account"
            smooth={true}
            duration={500}
          >
            Profile
          </Link>
        </li>
        <li className="py-6 text-4xl">
          <Link
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            to="progress"
            smooth={true}
            duration={500}
          >
            Progress
          </Link>
        </li>
        <li className="py-6 text-4xl">
          <Link
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            to="goals"
            smooth={true}
            duration={500}
          >
            Goals
          </Link>
        </li>
        <a className="  py-6 text-4xl">
          <Link
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            to="groups"
            smooth={true}
            duration={500}
          >
            Groups
          </Link>
        </a>
        <li className="py-6 text-4xl">
          <Link
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            to="feedback"
            smooth={true}
            duration={500}
          >
            Feedback
          </Link>
        </li>
        {/* <li className="py-6 text-4xl">
          <a
            onClick={handleClick}
            style={{ cursor: "pointer" }}
            className=" text-decoration-line: underline"
            href="https://github.com/mtiann3/mtiann3"
            smooth={true}
            duration={500}
          >
            Code (GitHub)
          </a>
        </li> */}
      </ul>
      {user?.displayName ? (
        <button
          className=" hover:text-[#e11624] font-bold text-2xl text-white"
          onClick={handleSignOut}
        >
          Logout
        </button>
      ) : (
        <Link to={"/signin"}>
          <button className=" hover:text-[#e11624] font-bold text-2xl text-white">
            {" "}
            Sign In
          </button>
        </Link>
      )}
    </div>
  );
};

export default Navbar;
