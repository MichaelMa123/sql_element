#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ELEMENT_NAME=$1
if [[ -n $ELEMENT_NAME ]]; then
  element_id=$($PSQL "SELECT atomic_number FROM elements WHERE CAST(atomic_number AS TEXT) = '$ELEMENT_NAME' OR name = '$ELEMENT_NAME' OR symbol = '$ELEMENT_NAME';")
  if [[ -n $element_id ]]; then
    symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$element_id")
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$element_id")
    type_id=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$element_id")
    type=$($PSQL "SELECT type FROM types WHERE type_id=$type_id")
    atomic_mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$element_id")
    melting_point_celsius=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$element_id")
    boiling_point_celsius=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$element_id")
    echo "The element with atomic number $element_id is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
  else
    echo I could not find that element in the database.
  fi
else
  echo "Please provide an element as an argument."
fi