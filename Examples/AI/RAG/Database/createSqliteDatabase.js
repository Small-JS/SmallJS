import * as fs from "node:fs";
import { DatabaseSync } from "node:sqlite";
import * as sqliteVec from "sqlite-vec"

// Read SQL script.
let sqlPath = "createSqlite.sql";
console.log( "Reading SQL script: " + sqlPath );
let sql = fs.readFileSync( sqlPath ).toString();

// Create and open new database
let databasePath = "vector.db";
console.log( "Creating SQLite database: " + databasePath );
if ( fs.existsSync( databasePath ) )
	fs.unlinkSync( databasePath );
let database = new DatabaseSync( databasePath, { allowExtension: true } );

// Load vector extension and create vector table
sqliteVec.load( database );
database.exec( sql );

// Close
database.close();

console.log( "Done." );
