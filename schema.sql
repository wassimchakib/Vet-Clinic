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
