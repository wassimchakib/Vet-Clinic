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
select * from animals;

/* Transaction 2 */
begin;
Update animals set species = 'digimon' where name like '%mon';
Update animals set species = 'pokemon' where species is null;
commit;
select * from animals;

/* Transaction 3 */
begin;
delete from animals;
rollback;
select * from animals;

/* Transaction 4 */
begin;
delete from animals where date_of_birth > '2022-01-01';
savepoint sp1;
update animals set weight_kg = weight_kg * -1;
rollback to savepoint sp1;
update animals set weight_kg = weight_kg * -1 where weight_kg < 0;
commit;

/* How many animals are there? */
select count(*) from animals;
/* How many animals have never tried to escape? */
select count(name) from animals where escape_attempts > 0;
/* What is the average weight of animals? */
select avg(weight_kg) from animals;
/* Who escapes the most, neutered or not neutered animals? */
select count(*), neutered from animals where escape_attempts > 0 group by neutered order by count desc;
/* What is the minimum and maximum weight of each type of animal? */
select min(weight_kg) as min_weight, max(weight_kg) as max_weight, species from animals group by species;
/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
select species, avg(escape_attempts) from animals where date_of_birth between '1990-01-01' and '2000-12-31' group by species;

/* What animals belong to Melody Pond? */
select name, full_name from animals join owners on animals.owner_id = owners.id where full_name = 'Jennifer Orwell';
/* List of all animals that are pokemon (their type is Pokemon). */
select animals.name, species.name from animals join species on animals.species_id = species.id where species.name = 'Pokemon';
/* List all owners and their animals, remember to include those that don't own any animal. */
select full_name, name from owners left join animals on owners.id = animals.owner_id;
/* How many animals are there per species? */
select species.name as species, count(animals.name) as nb_of_animals from animals join species on animals.species_id = species.id group by species;
/* List all Digimon owned by Jennifer Orwell. */
select animals.name as animal, species.name as species, owners.full_name as owner from animals join species on animals.species_id = species.id join owners on animals.owner_id = owners.id where species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell';
/* List all animals owned by Dean Winchester that haven't tried to escape. */
select animals.name as animal, animals.escape_attempts, owners.full_name as owner  from animals join owners on animals.owner_id = owners.id where owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;
/* Who owns the most animals? */
select owners.full_name, count(animals.name) as nb_of_animals_owned from owners join animals on owners.id = animals.owner_id group by full_name order by nb_of_animals_owned desc;

/* Who was the last animal seen by William Tatcher? */
select vets.name as vet , visits.date_of_visit as visit_date, animals.name as animal from visits join vets on vets_id = vets.id join animals on animals_id = animals.id where vets_id = (select id from vets where name = 'William Tatcher') order by date_of_visit desc limit 1;
/* How many different animals did Stephanie Mendez see? */
select name, count(*) as nb_of_different_animals from visits join vets on visits.vets_id = vets.id where visits.vets_id = (select id from vets where name = 'Stephanie Mendez') group by vets.name;
/* List all vets and their specialties, including vets with no specialties. */
select vets.name, species.name from vets left join specializations on vets.id = specializations.vets_id left join species on species_id = species.id;
/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
select animals.name as animals from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id where visits.vets_id = (select id from vets where name = 'Stephanie Mendez') and visits.date_of_visit between '2020-04-01' and '2020-08-30';
/* What animal has the most visits to vets? */
select animals.name, count(*) as number_of_visits from visits join animals on visits.animals_id = animals.id group by animals.name order by number_of_visits desc limit 1;
/* Who was Maisy Smith's first visit */
select animals.name as animal, vets.name as vet_name, visits.date_of_visit from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id where vets_id = (select id from vets where name = 'Maisy Smith') order by date_of_visit limit 1;
/* Details for most recent visit: animal information, vet information, and date of visit. */
select animals.name as animal, animals.date_of_birth as animal_birthday, animals.escape_attempts, animals.neutered, animals.weight_kg, owners.full_name as owner, species.name as species, vets.name as vet, vets.age, vets.date_of_graduation, visits.date_of_visit from visits join animals on visits.animals_id = animals.id join owners on animals.owner_id = owners.id join species on animals.species_id = species.id join vets on visits.vets_id = vets.id order by date_of_visit desc limit 1;
/* How many visits were with a vet that did not specialize in that animal's species */
select count(*) as nb_of_visits from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id join specializations on visits.vets_id = specializations.vets_id join species on species.id = animals.species_id 
where animals.species_id != specializations.species_id;
/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
select count(visits.animals_id) as nb_of_visits ,animals.name, species.name,  vets.name from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id join species on animals.species_id = species.id where visits.vets_id = (select id from vets where name = 'Maisy Smith') group by visits.animals_id, animals.name, vets.name, species.name order by nb_of_visits desc limit 1;


EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';