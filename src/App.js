import React from "react";
import { Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar";
import Protected from "./components/Protected";
import { AuthContextProvider } from "./context/AuthContext";
import Account from "./pages/Account";
import Home from "./pages/Home";
import Signin from "./pages/Signin";
import Progress from "./pages/Progress";
import Dashboard from "./pages/Dashboard";
import Feedback from "./pages/Feedback";
import Export from "./pages/Export";
import Goals from "./pages/Goals";
import Nutrition from "./pages/Nutrition";

function App() {
  return (
    <div>
      <AuthContextProvider>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/signin" element={<Signin />} />
          <Route
            path="/account"
            element={
              <Protected>
                <Account />
              </Protected>
            }
          />
          <Route path="/nutrition" element={<Nutrition />} />

          <Route path="/progress" element={<Progress />} />
          <Route path="/goals" element={<Goals />} />
          <Route path="/export" element={<Export />} />
          <Route path="/feedback" element={<Feedback />} />
        </Routes>
      </AuthContextProvider>
    </div>
  );
}

export default App;
