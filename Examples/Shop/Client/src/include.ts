// Replace tags <include src="<file path>"> with referenced HTML
// To use it put this at the bottom of HTML pages with <include ...> tags:
// 	<script type="module" src="/Script/include.js"></script>

function loadIncludes()
{
	const includeNodes = document.getElementsByTagName( 'include' );

	for( const includeNode of includeNodes ) {
		let filePath = includeNode.getAttribute( 'src' );
		if( filePath )
			fetch( filePath ).then( file => {
				file.text().then( content => {
					includeNode.insertAdjacentHTML( 'afterend', content );
					includeNode.remove() } ) } ) };
}

loadIncludes();
