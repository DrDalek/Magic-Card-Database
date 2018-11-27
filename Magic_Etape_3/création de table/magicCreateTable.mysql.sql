DROP TABLE IF EXISTS possession CASCADE;
DROP TABLE IF EXISTS carte_langue CASCADE;
DROP TABLE IF EXISTS carte_virtuelle CASCADE;
DROP TABLE IF EXISTS collection CASCADE;
DROP TABLE IF EXISTS langue_serie CASCADE;
DROP TABLE IF EXISTS langue CASCADE;
DROP TABLE IF EXISTS serie CASCADE;

CREATE TABLE serie (
 ser_code    VARCHAR(3) NOT NULL PRIMARY KEY,
 ser_nom     VARCHAR(30) NOT NULL,
 ser_date    DATE,
 ser_nbTotal INTEGER NOT NULL
);
CREATE TABLE langue (
 lang_id  INT AUTO_INCREMENT PRIMARY KEY,
 lang_nom VARCHAR(30) NOT NULL
);

CREATE TABLE langue_serie (
  lang_id  INT NOT NULL ,
  ser_code VARCHAR(3) NOT NULL ,
  FOREIGN KEY (lang_id) REFERENCES langue (lang_id),
  FOREIGN KEY (ser_code) REFERENCES serie (ser_code),
  PRIMARY KEY (lang_id, ser_code)
);

CREATE TABLE collection(
 col_id INT AUTO_INCREMENT PRIMARY KEY,
 col_nom VARCHAR(30) NOT NULL
);

CREATE TABLE carte_virtuelle (
 carte_id INT AUTO_INCREMENT PRIMARY KEY,
 carte_couleur CHAR NOT NULL CHECK(carte_couleur IN('W', 'B', 'N', 'R', 'V', 'M', 'I', 'T')),
 carte_type VARCHAR(20) NOT NULL CHECK(carte_type IN('terrain', 'creature', 'enchantement', 'rituel', 'ephemere', 'artefact')),
 carte_cout VARCHAR(10) NOT NULL,
 carte_force INT CHECK((carte_type = 'creature' AND carte_force >= -1) OR (carte_type != 'creature' AND carte_force IS NULL)),
 carte_endurance INT CHECK((carte_type = 'creature' AND carte_endurance >= -1) OR (carte_type != 'creature' AND carte_endurance IS NULL)),
 carte_artiste VARCHAR(50),
 carte_rarete INT NOT NULL CHECK(carte_rarete BETWEEN 0 AND 4),
 carte_ordre_serie INT NOT NULL,
 ser_code VARCHAR(3) NOT NULL ,
 FOREIGN KEY(ser_code) REFERENCES serie(ser_code)
);

CREATE TABLE carte_langue (
 carte_nom VARCHAR(30) NOT NULL,
 carte_texte VARCHAR(500) NOT NULL,
 carte_id INT NOT NULL,
 lang_id INT NOT NULL,
 FOREIGN KEY(carte_id) REFERENCES carte_virtuelle(carte_id),
 FOREIGN KEY(lang_id) REFERENCES langue(lang_id),
 PRIMARY KEY(carte_id, lang_id)
);

CREATE TABLE possession(
 col_id INT NOT NULL,
 carte_id INT NOT NULL,
 lang_id INT NOT NULL,
 pos_quantite INT,
 FOREIGN KEY(carte_id, lang_id) REFERENCES carte_langue(carte_id, lang_id),
 FOREIGN KEY(col_id) REFERENCES collection(col_id),
 PRIMARY KEY(col_id, carte_id, lang_id)
);
