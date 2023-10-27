-- @block
CREATE TABLE Users(
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  bio TEXT,
  country VARCHAR(2)
);

-- @block
INSERT INTO Users (email, bio, country)
VALUES (
  'hello@world.com',
  'i love strangers!',
  'US'
);

-- @block
INSERT INTO Users (email, bio, country)
VALUES
  ('hello@world.com', 'i love strangers!', 'US'),
  ('hola@munda.com', 'bar', 'MX'),
  ('bonjour@monde.com', 'baz', 'FR'),
);

-- @block
-- % as wildcard
SELECT email, id, country FROM Users

WHERE country = 'US'
AND id > 1
AND email LIKE 'hello%'

ORDER BY id DESC
LIMIT 2;

-- @block
-- faster queries by using index
CREATE INDEX email_index ON Users (email);

-- @block
-- cannot delete data that references data in another table
CREATE TABLE Rooms(
  id INT AUTO_INCREMENT,
  street VARCHAR(255),
  owner_id INT NOT NULL
  PRIMARY KEY (id),
  FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block
INSERT INTO Rooms (owner_id, street)
VALUES
  (1, 'san diego sailboat'),
  (1, 'nantucket cottage'),
  (1, 'vail cabin'),
  (1, 'sf cardboard box');

-- @block
-- use AS to avoid conflicting column names
SELECT
  Users.id AS user_id,
  Rooms.id AS room_id,
  email,
  street
SELECT * FROM Users
INNER JOIN Rooms
ON Rooms.owner_id = Users_id;

-- @block
CREATE TABLE Bookings(
  id INT AUTO_INCREMENT,
  guest_id INT NOT NULL,
  room_id INT NOT NULL,
  check_in DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (guest_id) REFERENCES Users(id),
  FOREIGN KEY (room_id) REFERENCES Rooms(id)
);


-- @block Rooms a user has booked
SELECT
  guest_id,
  street,
  check_in
FROM Bookings
INNER JOIN Rooms ON Rooms.owner_id = guest_id
WHERE guest_id = 1;

-- @block Guests who stayed in a room
SELECT
  room_id,
  guest_id,
  email,
  bio
FROM Bookings
INNER JOIN Users ON Users.id = guest_id
WHERE room_id = 2;

-- @block
DROP TABLE Users;
DROP DATABASE airbnb;