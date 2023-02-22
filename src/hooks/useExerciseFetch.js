import { useEffect, useState } from "react";

export const useExerciseFetch = url => {
  const [state, setState] = useState({ data: null, loading: true });

  useEffect(() => {
    const headers = { "X-Api-Key": "2kLFNSocLGSrUDczknoQww==bdwR08KZB6MeqpXL" };
    setState(state => ({ data: state.data, loading: true }));
    fetch(url, { headers })
      .then(x => x.text())
      .then(y => {
        setState({ data: y, loading: false });
      });
  }, [url, setState]);

  return state;
};