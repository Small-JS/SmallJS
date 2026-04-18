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
database.exec( sql );

console.log( "Done." );
