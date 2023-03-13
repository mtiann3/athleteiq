import React, { useState } from "react";

const ListView = ({ data }) => {
  const componentArray = [];
  console.log(data);
  const handleClick = (name) => {
    // console.log(name);
  };
  // console.log(data)
  const getItem = () => {
    for (var i = 0; i < data.length; i++) {
      componentArray.push(
        <li
          onClick={() => handleClick(data[i])}
          class="p-3 hover:bg-blue-600 hover:text-blue-200"
        >
          {data[i]}
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
export default ListView;
