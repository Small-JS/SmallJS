2024-09-08:\
Electron won't start properly on Windows if there is a file called "Node.js" in its startup folder.\
It will try to open that file iso the Node.js platform executable.\
That's why the module name here is changed to "Node1",\
producing "Node1.js" as compiled output that prevents this problem.
