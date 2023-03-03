import { useEffect, useState } from "react";

export const useExerciseFetch = (url, target) => {
  const [state, setState] = useState({
    data: null,
    loading: true,
    target: null,
    filteredData: [null],
  });

  const getFilteredData = (y) => {
    var tempNameArr = [];
    var length = Object.keys(JSON.parse(y)).length;
    for (var count = 0; count < length; count++) {
      tempNameArr.push(JSON.parse(y)[count].name);
    }
    // console.log(tempNameArr)
    return tempNameArr;
  };

  useEffect(() => {
    const headers = { "X-Api-Key": "2kLFNSocLGSrUDczknoQww==bdwR08KZB6MeqpXL" };
    setState((state) => ({ data: state.data, loading: true }));
    fetch(url, { headers })
      .then((x) => x.text())
      .then((y) => {
        setState({
          data: y,
          loading: false,
          filteredData: getFilteredData(y, "name"),
        });
      });
  }, [url, setState]);

  return state;
};
