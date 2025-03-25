import React, { useEffect, useState } from "react";
import Flashcards from "./components/Flashcards";
import axios from "axios";

function App() {
  const [flashcards, setFlashcards] = useState([]);

  useEffect(() => {
    axios
      .get("http://127.0.0.1:3000/flashcards")
      .then((response) => setFlashcards(response.data))
      .catch((error) => console.error("Error fetching flashcards:", error));
  }, []);

  return (
    <>
      <Flashcards flashcards={flashcards} />
    </>
  );
}

export default App;
