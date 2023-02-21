import { useState } from "react"

export const useExerciseForm = initialValues => {
    const [values, setValues] = useState(initialValues)
    return [
        values,
        e => {
            setValues({
                ...values,
                [e.target.name]: e.target.values
            });
        }
    ];
};