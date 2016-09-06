#!/bin/bash

#FILES=('allCountries.zip' 'alternateNames.zip' 'admin2Codes.txt' 'admin1CodesASCII.txt' 'featureCodes_en.txt' 'timeZones.txt' 'countryInfo.txt' 'shapes_simplified_low.zip');

#FILES=('allCountries.zip' 'alternateNames.zip' 'admin2Codes.txt' 'admin1CodesASCII.txt' 'featureCodes_en.txt' 'timeZones.txt' 'countryInfo.txt' 'shapes_simplified_low.zip');

FILES=('admin2Codes.txt')

[ -e data ] || mkdir data

cd data

for FILE in "${FILES[@]}"; do
	echo "Downloading $FILE..."
	[ -e $FILE ] || curl -O http://download.geonames.org/export/dump/{$FILE}
done

[ -e allCountries.zip ] &&  unzip allCountries.zip
[ -e alternateNames.zip ] && unzip alternateNames.zip
[ -e shapes_simplified_low.zip ] && unzip shapes_simplified_low.zip

[ -e countryInfo.txt ] && cat countryInfo.txt | grep -v "^#" >countryInfo-n.txt 

cd ..

DATA_PATH=$(pwd)

#sed -e "s@PATH_PLACEHOLDER@$DATA_PATH@g" import.sql.template > tmp_import.sql
[ -e data/admin2Codes.txt ] && sed -e "s@PATH_PLACEHOLDER@$DATA_PATH@g" admin2_code.sql.template > tmp_admin2_code.sql

echo "Importing data..."

#mysql -u root  --local-infile <tmp_import.sql
mysql -u root  --local-infile <tmp_admin2_code.sql

rm -f tmp*.sql
