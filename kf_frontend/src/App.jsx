import React, { useEffect, useState } from "react";
import FlashcardList from "./components/FlashcardList";
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
      <FlashcardList flashcards={flashcards} />
    </>
  );
}

export default App;
