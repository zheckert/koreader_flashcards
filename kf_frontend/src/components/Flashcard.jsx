import React, { useState } from "react";

function Flashcard({ key, word, definition }) {
  const [isFlipped, setIsFlipped] = useState(false);
  return isFlipped ? (
    <div
      style={{ display: "flex", gap: "10px", border: "1px solid black" }}
      onClick={() => setIsFlipped(!isFlipped)}
    >
      <div>{word}:</div>
    </div>
  ) : (
    <div
      style={{ display: "flex", gap: "10px", border: "1px solid black" }}
      onClick={() => setIsFlipped(!isFlipped)}
    >
      <div>{definition}</div>
    </div>
  );
}

export default Flashcard;
