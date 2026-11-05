// Links the folder ./bin to the NW.js SDK that the npm package 'nw' downloaded.
// That folder name contains the NW.js version, platform and architecture,
// e.g. node_modules/nw/nwjs-sdk-v0.119.0-win-x64,
// so this link gives .vscode/launch.json a fixed path to the nw executable.
// On Windows a directory junction is used, which does not require admin rights.

import fs from "node:fs";
import process from "node:process";
import { findpath } from "nw";

const linkPath = "bin";
const nwDir = await findpath( "all" );

if( !fs.existsSync( nwDir ) ) {
	console.error( `NW.js folder not found: ${nwDir}` );
	process.exit( 1 );
}

let linkStat = null;
try { linkStat = fs.lstatSync( linkPath ); } catch { }
if( linkStat ) {
	if( !linkStat.isSymbolicLink() ) {
		console.error( `Not replacing ./${linkPath}, because it is not a link.` );
		process.exit( 1 );
	}
	fs.unlinkSync( linkPath );
}

fs.symlinkSync( nwDir, linkPath, "junction" );
console.log( `Linked ./${linkPath} to: ${nwDir}` );
