-- In DB Browser, load vec0.dll extension from ./node_modules/sqlite-vec<platform>/vec0*

CREATE VIRTUAL TABLE documents USING vec0(
	id INTEGER PRIMARY KEY,
	embedding FLOAT[768],
	content TEXT );
