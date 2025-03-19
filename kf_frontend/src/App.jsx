import React, { useEffect, useState } from "react";
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
      {flashcards.map((card) => (
        <div key={card.id} style={{ display: "flex", gap: "10px" }}>
          <div>{card.word}:</div>
          <div>{card.definition?.text}</div>
        </div>
      ))}
    </>
  );
}

export default App;
