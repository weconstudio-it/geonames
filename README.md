# geonames
Import geonames.org data to a MySQL database.

#Usage
-----
First of all you need a working MySQL instance on localhost accessible by local
user without authentication (e.g. using ~/.my.cnf file).

Then you only need to launch the geonames_import.sh script:

	$./geonames_import.sh

#Remarks
-----
Geonames data is downloaded from geonames.org. The whole process may take a 
while depending on your bandwidth and machine performances.