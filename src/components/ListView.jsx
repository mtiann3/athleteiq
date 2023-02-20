import React from "react";

const ListView = () => {
  const arr = ["Hi", "Hello", "bob", "yes"];

  const getItem = () => {
    for (var i = 0; i < arr.length; i++) {
      return (
        <ul class="divide-y-2 divide-gray-100">
          <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
          <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
          <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
          <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
        </ul>
      );
    }
  };

  return (
    <div class="w-full bg-white rounded-lg shadow-lg lg:w-1/3">
      <ul class="divide-y-2 divide-gray-100">
        {/* <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
        <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
        <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li>
        <li class="p-3 hover:bg-blue-600 hover:text-blue-200">10-Yard Fly</li> */}
        
      </ul>
    </div>
  );
};

export default ListView;
