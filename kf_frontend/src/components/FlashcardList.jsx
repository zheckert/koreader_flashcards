import React from "react";
import Flashcard from "./Flashcard";

function FlashcardList({ flashcards }) {
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

export default FlashcardList;
