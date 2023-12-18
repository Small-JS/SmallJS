// Replace tags <include src="<file path>"> with referenced HTML

function loadIncludes()
{
	const includeNodes = document.getElementsByTagName( 'include' );
	for( const includeNode of includeNodes ) {
		let filePath = includeNode.getAttribute( 'src' );
		if( filePath )
			fetch( filePath ).then( file =>
			{
				file.text().then( content =>
				{
					includeNode.insertAdjacentHTML( 'afterend', content );
					includeNode.remove();
				} );
			} );
	};
}

loadIncludes();
