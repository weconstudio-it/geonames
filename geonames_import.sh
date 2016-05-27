#!/bin/bash

#FILES=('allCountries.zip' 'alternateNames.zip' 'admin2Codes.txt' 'admin1CodesASCII.txt' 'featureCodes_en.txt' 'timeZones.txt' 'countryInfo.txt' 'shapes_simplified_low.zip');

FILES=('allCountries.zip' 'alternateNames.zip' 'admin2Codes.txt' 'admin1CodesASCII.txt' 'featureCodes_en.txt' 'timeZones.txt' 'countryInfo.txt' 'shapes_simplified_low.zip');

[ -e data ] || mkdir data

cd data

for FILE in "${FILES[@]}"; do
	echo "Downloading $FILE..."
	[ -e $FILE ] || curl -O http://download.geonames.org/export/dump/{$FILE}
done

[ -e allCountries.txt ] || unzip allCountries.zip
[ -e alternateNames.txt ] || unzip alternateNames.zip
[ -e shapes_simplified_low.txt ] || unzip shapes_simplified_low.zip
cat countryInfo.txt | grep -v "^#" >countryInfo-n.txt 

cd ..

DATA_PATH=$(pwd)

sed -e "s@PATH_PLACEHOLDER@$DATA_PATH@g" import.sql.template > tmp_import.sql

echo "Importing data..."

mysql -u root -proot --local-infile <tmp_import.sql

rm tmp_import.sql
