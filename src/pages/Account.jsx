import React from 'react';
import { UserAuth } from '../context/AuthContext';

const Account = () => {
  const { logOut, user } = UserAuth();

  const handleSignOut = async () => {
    try {
      await logOut();
    } catch (error) {
      console.log(error);
    }
  };

  return (
    // background div
    <div className='w-auto h-screen p-10  m-auto bg-[#46433f]' >
      <h1 class="mb-4 text-center text-[#ffffff] bg-[#b52e2b] text-4xl font-extrabold leading-none tracking-tight  md:text-5xl lg:text-6xl ">Profile</h1>
      <div>
        <p className='text-[#e11624] text-center font-medium text-2xl'>Welcome, {user?.displayName}, ({user?.email}) </p>
      </div>
    </div>
  );
};

export default Account;