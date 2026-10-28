# Experiment 7: Normalization of the Sales Relation

## Aim

To identify functional dependencies in a denormalized Sales table and normalize the relation step-by-step from UNF to 1NF, 2NF, 3NF and BCNF, and to verify lossless join and dependency preservation using SQL queries.

## Concepts

- Functional dependencies
- Candidate key `(Sale_ID, Product_ID)`
- Repeating and multi-valued attributes
- Normalization from UNF to 1NF, 2NF, 3NF and BCNF
- Lossless join
- Dependency preservation
- Primary keys and foreign keys

## Procedure

1. Create and populate `Sales_UNF` with product values stored as comma-separated lists.
2. Identify the functional dependencies and create `Sales_1NF` with one product per row.
3. Decompose the relation into `Sale_2NF` and `Sale_Item_2NF` and verify the records.
4. Decompose the relation into `Customer`, `Salesperson`, `Product`, `Sale` and `Sale_Item` and verify the 3NF result.
5. Verify the BCNF condition by checking the determinants and table keys.
6. Compare the original and reconstructed row counts and perform dependency-preservation checks.

## How to Run

Run `experiment_07.sql` in MySQL Workbench or any MySQL-compatible client.

Execute the script from the beginning so that the `Experiment7` database and all required tables are created correctly.

## Result

The Sales relation is normalized from UNF to BCNF. The final decomposition preserves the required functional dependencies and supports lossless reconstruction of the original 1NF records.
