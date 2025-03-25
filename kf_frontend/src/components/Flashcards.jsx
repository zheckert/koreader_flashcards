import React from "react";
import Flashcard from "./Flashcard";

function Flashcards({ flashcards }) {
  return (
    <>
      {flashcards.map((card) => (
        <Flashcard
          key={card.id}
          word={card.word}
          definition={card.definition?.text}
        />
      ))}
    </>
  );
}

export default Flashcards;
