import React, { useState } from "react";
import "../../styles.css";

function Flashcard({ word, definition }) {
  const [isFlipped, setIsFlipped] = useState(false);
  const handleClick = () => {
    setIsFlipped(!isFlipped);
  };

  return (
    <div className="flashcard" onClick={handleClick}>
      {isFlipped ? <div>{definition}</div> : <div>{word}</div>}
    </div>
  );
}

export default Flashcard;
