DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\c universe

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(30) NOT NULL,
    diameter_in_light_years INT NOT NULL,
    has_black_hole BOOLEAN NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    spectral_class VARCHAR(10) NOT NULL,
    temperature_kelvin INT NOT NULL,
    is_main_sequence BOOLEAN NOT NULL,
    age_in_billions_years NUMERIC(4, 2) NOT NULL
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    star_id INT NOT NULL REFERENCES star(star_id),
    distance_from_star NUMERIC(10, 2) NOT NULL,
    orbital_period_days INT NOT NULL,
    has_life BOOLEAN NOT NULL,
    atmosphere TEXT NOT NULL,
    surface_temp_celsius NUMERIC(6, 2) NOT NULL
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    diameter_km INT NOT NULL,
    orbital_period_days INT NOT NULL,
    is_tidal_locked BOOLEAN NOT NULL,
    discovered_year INT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE comet (
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    orbital_period_years INT NOT NULL,
    is_periodic BOOLEAN NOT NULL,
    tail_length_km INT NOT NULL,
    composition TEXT NOT NULL
);

INSERT INTO galaxy (name, type, diameter_in_light_years, has_black_hole, description) VALUES
    ('Andromeda', 'Spiral', 220000, true, 'A large spiral galaxy in the Local Group.'),
    ('Milky Way', 'Barred Spiral', 100000, true, 'Our home galaxy containing the Solar System.'),
    ('Whirlpool', 'Spiral', 60000, false, 'A grand-design spiral galaxy with prominent arms.'),
    ('Sombrero', 'Lenticular', 50000, true, 'A bright galaxy with a large central bulge.'),
    ('Pinwheel', 'Spiral', 85000, false, 'A face-on spiral galaxy with dense star-forming regions.'),
    ('NGC 1300', 'Barred Spiral', 110000, true, 'A barred spiral galaxy with a large central bar.');

INSERT INTO star (name, galaxy_id, spectral_class, temperature_kelvin, is_main_sequence, age_in_billions_years) VALUES
    ('Sol', 2, 'G', 5778, true, 4.60),
    ('Sirius A', 2, 'A', 9940, true, 0.25),
    ('Betelgeuse', 2, 'M', 3600, false, 10.00),
    ('Rigel', 2, 'B', 11000, true, 8.00),
    ('Alpha Centauri A', 2, 'G', 5790, true, 5.30),
    ('M31-1', 1, 'K', 5000, true, 6.50);

INSERT INTO planet (name, star_id, distance_from_star, orbital_period_days, has_life, atmosphere, surface_temp_celsius) VALUES
    ('Mercury', 1, 0.39, 88, false, 'Thin exosphere', 167.00),
    ('Venus', 1, 0.72, 225, false, 'Carbon dioxide', 464.00),
    ('Earth', 1, 1.00, 365, true, 'Nitrogen and oxygen', 15.00),
    ('Mars', 1, 1.52, 687, false, 'Thin carbon dioxide', -65.00),
    ('Jupiter', 1, 5.20, 4333, false, 'Hydrogen and helium', -110.00),
    ('Saturn', 1, 9.58, 10759, false, 'Hydrogen and helium', -140.00),
    ('Uranus', 1, 19.20, 30687, false, 'Hydrogen, helium, methane', -195.00),
    ('Neptune', 1, 30.05, 60190, false, 'Hydrogen, helium, methane', -200.00),
    ('Proxima b', 5, 0.05, 11, false, 'Nitrogen and oxygen', -39.00),
    ('Kepler-442b', 2, 0.41, 112, false, 'Nitrogen and oxygen', -12.00),
    ('HD 209458 b', 2, 0.05, 3, false, 'Hydrogen and helium', 970.00),
    ('TRAPPIST-1e', 2, 0.03, 6, false, 'Nitrogen and oxygen', -22.00);

INSERT INTO moon (name, planet_id, diameter_km, orbital_period_days, is_tidal_locked, discovered_year, description) VALUES
    ('Moon', 3, 3474, 27, true, -2000, 'Earths natural satellite orbiting our planet.'),
    ('Phobos', 4, 22, 0, true, 1877, 'The larger and closer of Mars two moons.'),
    ('Deimos', 4, 13, 1, true, 1877, 'A small irregular moon of Mars.'),
    ('Io', 5, 3643, 1, true, 1610, 'Volcanically active moon orbiting Jupiter.'),
    ('Europa', 5, 3122, 3, true, 1610, 'An icy moon with a subsurface ocean.'),
    ('Ganymede', 5, 5268, 7, true, 1610, 'The largest moon in the Solar System.'),
    ('Callisto', 5, 4821, 16, true, 1610, 'A heavily cratered moon of Jupiter.'),
    ('Titan', 6, 5149, 16, true, 1655, 'A large moon with a thick atmosphere.'),
    ('Rhea', 6, 1528, 4, true, 1672, 'An icy moon of Saturn with bright ice cliffs.'),
    ('Iapetus', 6, 1469, 79, true, 1671, 'A moon with a dramatic two-tone appearance.'),
    ('Dione', 6, 1123, 2, true, 1684, 'A bright icy moon with fractures.'),
    ('Tethys', 6, 1062, 1, true, 1684, 'A large icy moon with a giant impact basin.'),
    ('Titania', 7, 1578, 8, true, 1787, 'The largest moon of Uranus.'),
    ('Oberon', 7, 1523, 13, true, 1787, 'A dark and heavily cratered Uranian moon.'),
    ('Miranda', 7, 472, 1, true, 1948, 'A moon with varied and unusual geology.'),
    ('Triton', 8, 2707, 5, true, 1846, 'A captured moon of Neptune with geysers.'),
    ('Proteus', 8, 420, 1, true, 1989, 'The largest irregular moon of Neptune.'),
    ('Nereid', 8, 340, 360, true, 1949, 'A distant irregular moon of Neptune.'),
    ('Charon', 3, 1212, 6, true, 1978, 'The large moon orbiting Pluto, not Earth.'),
    ('Enceladus', 6, 504, 1, true, 1789, 'An icy moon with water plumes in the south pole.');

INSERT INTO comet (name, galaxy_id, orbital_period_years, is_periodic, tail_length_km, composition) VALUES
    ('Halley', 2, 76, true, 100000, 'Ice, dust, and rocky material'),
    ('Hale-Bopp', 2, 2537, false, 250000, 'Ice, dust, and organic compounds'),
    ('NEOWISE', 2, 6700, false, 180000, 'Ice, dust, and carbon compounds'),
    ('Borrelly', 2, 6, true, 80000, 'Carbon-rich ice and dust'),
    ('Wild 2', 2, 6, true, 90000, 'Dust and frozen gases');
