INSERT INTO animals VALUES (1, 'Agumon', '2020-02-03', 0, '1', 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', '2018-11-15', 2, '1', 8);
INSERT INTO animals VALUES (3, 'Pikachu', '2021-01-07', 1, '0', 15.04);
INSERT INTO animals VALUES (4, 'Devimon', '2017-05-12', 5, '1', 11);
INSERT INTO animals VALUES (5, 'Charmander', '2020-02-08', 0, '0', -11);
INSERT INTO animals VALUES (6, 'Plantmon', '2021-11-15', 2, '1', -5.7);
INSERT INTO animals VALUES (7, 'Squirtle', '1993-04-02', 3, '0', -12.13);
INSERT INTO animals VALUES (8, 'Angemon', '2005-06-12', 1, '1', -45);
INSERT INTO animals VALUES (9, 'Boarmon', '2005-06-07', 7, '1', 20.4);
INSERT INTO animals VALUES (10, 'Blossom', '1998-10-13', 3, '1', 17);
INSERT INTO animals VALUES (11, 'Ditto', '2022-05-14', 4, '1', 22);

INSERT INTO owners(full_name, age) values ('Sam Smith', 34);
INSERT INTO owners(full_name, age) values ('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) values ('Bob', 45);
INSERT INTO owners(full_name, age) values ('Melody Pond', 77);
INSERT INTO owners(full_name, age) values ('Dean Winchester', 14);
INSERT INTO owners(full_name, age) values ('Jodie Whittaker', 38);

INSERT INTO species(name) values ('Pokemon');
INSERT INTO species(name) values ('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id is null;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
