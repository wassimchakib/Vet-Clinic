/* Find all animals whose name ends in "mon". */
select * from animals where name like '%mon';
/* List the name of all animals born between 2016 and 2019.*/ 
select name from animals where date_of_birth between '2016-01-01' and '2019-01-01';
/* List the name of all animals that are neutered and have less than 3 escape attempts.*/ 
select name from animals where neutered = '1' and escape_attempts < 3;
/* List the date of birth of all animals named either "Agumon" or "Pikachu".*/
select date_of_birth from animals where name in ('Agumon', 'Pikachu');
/* List name and escape attempts of animals that weigh more than 10.5kg*/
select name, escape_attempts from animals where weight_kg > 10.5;
/* Find all animals that are neutered.*/
select * from animals where neutered = '1';
/* Find all animals not named Gabumon.*/
select * from animals where not name='Gabumon';
/* Find all animals with a weight between 10.4kg and 17.3kg 
(including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
select * from animals where weight_kg between 10.4 and 17.3;

/* Transaction 1 : update the animals table by setting the species column to unspecified.*/
begin;
Update animals set species = 'unspecified';
rollback;

/* Transaction 2 */
begin;
Update animals set species = 'digimon' where name like '%mon';
Update animals set species = 'pokemon' where species is null;
commit;

/* Transaction 3 */
begin;
delete from animals;
rollback;

/* Transaction 4 */
begin;
delete from animals where date_of_birth > '2022-01-01';
savepoint sp1;
update animals set weight_kg = weight_kg * -1;
rollback to savepoint sp1;
update animals set weight_kg = weight_kg * -1 where weight_kg < 0;
commit;
