import React from "react";

function Flashcard({ key, word, definition }) {
  return (
    <div
      key={key}
      style={{ display: "flex", gap: "10px", border: "1px solid black" }}
    >
      <div>{word}:</div>
      <div>{definition}</div>
    </div>
  );
}

export default Flashcard;
