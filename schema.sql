/* Database schema to keep the structure of entire database. */

create table animals(
  id integer generated always as identity primary key,
  name varchar(100),
  date_of_birth date,
  escape_attempts integer,
  neutered bit,
  weight_kg decimal,
  species_id integer foreign key(fk_species) references species(id) on delete cascade,
  owner_id integer foreign key(fk_owners) references owners(id) on delete cascade
);


/* Create a table named owners */
create table owners(
  id integer generated always as identity primary key,
  full_name varchar,
  age integer
);

/* Create a table named species */
create table species(
  id integer generated always as identity primary key,
  name varchar
);

/* Create a table named vets */
create table vets(
  id integer generated always as identity primary key,
  name varchar,
  age integer,
  date_of_graduation date
);

/* Create table specializations many to many relationship between species and vets */
create table specializations(
  species_id integer,
  vets_id integer,
  primary key(species_id, vets_id),
  constraint fk_species foreign key(species_id) references species(id) on delete cascade,
  constraint fk_vets foreign key(species_id) references vets(id) on delete cascade
);

/* Create table visits many to many relationship between animals and vets */
create table visits(
  animals_id integer,
  vets_id integer,
  date_of_visit date,
  primary key(animals_id, vets_id),
  constraint fk_animals foreign key(animals_id) references animals(id) on delete cascade,
  constraint fk_vets foreign key(vets_id) references vets(id) on delete cascade
);