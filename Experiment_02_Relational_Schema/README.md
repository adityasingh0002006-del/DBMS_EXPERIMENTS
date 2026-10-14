Experiment 2 – Relational Schema Implementation
Aim
To convert the ER diagram into a relational schema and implement it using MySQL CREATE TABLE statements with primary keys, foreign keys, NOT NULL, UNIQUE, ON DELETE CASCADE, and ON DELETE SET NULL constraints. To insert sample data and demonstrate referential integrity violations.
Tables
- Customer
- Seller
- Category
- Product
- Order
- Address
- OrderItem
- Payment
- Delivery
Constraints Demonstrated
- Primary keys
- Composite primary keys
- Foreign keys
- NOT NULL
- UNIQUE
- ON DELETE CASCADE
- ON DELETE SET NULL
- Referential integrity
Files
- experiment_02.sql – Complete MySQL source code
- Experiment_02_Complete.pdf – Complete experiment write-up with source code and expected violation output
Referential Integrity Test
The script attempts to insert an Order with CustomerID = 999, while that customer does not exist. MySQL rejects the row with foreign-key error 1452.
