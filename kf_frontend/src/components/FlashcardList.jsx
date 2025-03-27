import React from "react";
import Flashcard from "./Flashcard";

function FlashcardList({ flashcards }) {
  return (
    <div className="flashcard-grid">
      {flashcards.map((card) => (
        <Flashcard
          key={card.id}
          word={card.word}
          definition={card.definition?.text}
        />
      ))}
    </div>
  );
}

export default FlashcardList;
