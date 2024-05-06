// This is "fake" replacement for the SourceNode class in the npm package source-node
// It works in a browser and has the functionlalities:
// add() source, prepend() source, generate source tree with toString().

export class SourceNode
{
	source: string = "";
	children: SourceNode[] = [];

	constructor(
		line: number | null,
		column: number | null,
		source: string | null,
		chunks?: Array<( string | SourceNode )> | SourceNode | string,
		name?: string )
	{
		if( typeof source === 'string' )
			this.source = source;

		if( chunks )
			this.add( chunks );
	}

	add( chunks: Array<( string | SourceNode )> | SourceNode | string ): SourceNode
	{
		if( typeof chunks === "string" )
			this.children.push( new SourceNode( null, null, chunks ) );
		else if( chunks instanceof SourceNode  )
			this.children.push( chunks );
		else if( chunks instanceof Array )
			for( let node of chunks as SourceNode[] )
				this.children.push( node );
		else
			throw new TypeError( "Expected a string, SourceNode or an array of SourceNodes: " + chunks );

		return this;
	}

	prepend( chunks: Array<( string | SourceNode )> | SourceNode | string ): SourceNode
	{
		if( this.source != "" )
			this.children.unshift( new SourceNode( null, null, this.source ) );

		if( typeof chunks === "string" )
			this.children.unshift( new SourceNode( null, null, chunks ) );
		else if( chunks instanceof SourceNode  )
			this.children.unshift( chunks );
		else if( chunks instanceof Array )
			for( let node of chunks as SourceNode[] )
				this.children.unshift( node );
		else
			throw new TypeError( "Expected a string, SourceNode or an array of SourceNodes: " + chunks );

		return this;
	}

	toString(): string
	{
		let source = this.source
		for( let child of this.children )
			source += child.toString();
		return source;
	}
}
