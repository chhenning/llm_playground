from pydantic import BaseModel, Field
from typing import List


class TextChunk(BaseModel):
    id: int = Field(..., description="The chunk ID assigned by LLM.")
    chunk: str = Field(..., description="The text chunk.")


class TextChunks(BaseModel):
    chunks: List[TextChunk] = Field(..., description="List of text chunks.")


class TextChunkQuestions(BaseModel):
    chunk_id: int = Field(..., description="The chunk_id as supplied in the input.")
    questions: List[str] = Field(
        ..., description="A list of relevant question for a text chunk."
    )
