import React, { useState } from "react";

function Flashcard({ word, definition }) {
  const [isFlipped, setIsFlipped] = useState(false);
  return (
    <div
      style={{ display: "flex", gap: "10px", border: "1px solid black" }}
      onClick={() => setIsFlipped(!isFlipped)}
    >
      {isFlipped ? <div>{definition}</div> : <div>{word}:</div>}
    </div>
  );
}

export default Flashcard;
