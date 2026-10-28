import * as fs from "node:fs";
import { DatabaseSync } from "node:sqlite";

let sqlPath = "SmallJS.sql";
console.log( "Reading SQL script: " + sqlPath );
let sql = fs.readFileSync( sqlPath ).toString();

let databasePath = "smalljs.db";
console.log( "Creating SQLite database: " + databasePath );
if ( fs.existsSync( databasePath ) )
	fs.unlinkSync( databasePath );
let database = new DatabaseSync( databasePath );
try {
	database.exec( sql );
} catch ( error ) {
	// Do not leave a partially created database behind.
	database.close();
	fs.unlinkSync( databasePath );
	throw error;
}
database.close();

console.log( "Done." );
