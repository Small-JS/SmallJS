// Keeps a position in a string being parsed
// with string index, line number and column number.

export class Position
{
	index: number = 0;
	line: number = 1;
	column: number = 1;
	tabbedColumn: number = 1;

	static tabSize = 4;

	// Return shalow copy of this.

	copy(): Position
	{
		let result = new Position

		result.index = this.index;
		result.line = this.line;
		result.column = this.column;
		result.tabbedColumn = this.tabbedColumn;

		return result;
	}

	// Increment index, line and column, depending on char parsed.
	// Returns incremented index.

	increment( char: string ): number
	{
		this.index++;
		if( char == "\n" ) {
			this.line++;
			this.column = 1;
			this.tabbedColumn = 1;
		}
		else {
			this.column++;
			if( char == "\t" )
				this.tabbedColumn += Position.tabSize;
			else
				this.tabbedColumn++;
		}

		return this.index;
	}

}

