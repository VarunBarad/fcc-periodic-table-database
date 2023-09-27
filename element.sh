#!/bin/bash
set -e

if [[ -z $1 ]]; then
	echo "Please provide an element as an argument."
else
	if [ "$1" -eq "$1" ] 2>/dev/null; then
		atomic_number=$1
		atomic_symbol=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select symbol from elements where atomic_number = $atomic_number")
		if [[ -z "$atomic_symbol" ]]; then
			echo "I could not find that element in the database."
		else
			atomic_name=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select name from elements where atomic_number = $atomic_number")
			atomic_type=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select type from types inner join properties on types.type_id = properties.type_id where properties.atomic_number = $atomic_number")
			atomic_mass=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select atomic_mass from properties where atomic_number = $atomic_number")
			boiling_point=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select boiling_point_celsius from properties where atomic_number = $atomic_number")
			melting_point=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select melting_point_celsius from properties where atomic_number = $atomic_number")
			echo "The element with atomic number $atomic_number is $atomic_name ($atomic_symbol). It's a $atomic_type, with a mass of $atomic_mass amu. $atomic_name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
		fi
	else
		# Search assuming input is symbol
		atomic_number=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select atomic_number from elements where symbol = '$1'")
		if [[ -z "$atomic_number" ]]; then
			# Search assuming input is element name
			atomic_number=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select atomic_number from elements where name = '$1'")
			if [[ -z "$atomic_number" ]]; then
				echo "I could not find that element in the database."
			else
				atomic_name=$1
				atomic_symbol=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select symbol from elements where atomic_number = $atomic_number")
				atomic_type=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select type from types inner join properties on types.type_id = properties.type_id where properties.atomic_number = $atomic_number")
				atomic_mass=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select atomic_mass from properties where atomic_number = $atomic_number")
				boiling_point=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select boiling_point_celsius from properties where atomic_number = $atomic_number")
				melting_point=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select melting_point_celsius from properties where atomic_number = $atomic_number")
				echo "The element with atomic number $atomic_number is $atomic_name ($atomic_symbol). It's a $atomic_type, with a mass of $atomic_mass amu. $atomic_name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
			fi
		else
			atomic_symbol=$1
			atomic_name=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select name from elements where atomic_number = $atomic_number")
			atomic_type=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select type from types inner join properties on types.type_id = properties.type_id where properties.atomic_number = $atomic_number")
			atomic_mass=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select atomic_mass from properties where atomic_number = $atomic_number")
			boiling_point=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select boiling_point_celsius from properties where atomic_number = $atomic_number")
			melting_point=$(psql --username=freecodecamp --dbname=periodic_table --quiet --no-align --tuples-only --field-separator ',' --command "select melting_point_celsius from properties where atomic_number = $atomic_number")
			echo "The element with atomic number $atomic_number is $atomic_name ($atomic_symbol). It's a $atomic_type, with a mass of $atomic_mass amu. $atomic_name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
		fi
	fi
fi