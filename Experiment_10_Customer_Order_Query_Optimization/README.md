# Experiment 10: Customer Order Query Optimization

## Aim

To generate a dataset containing at least 10,000 rows, identify five slow SQL queries using `EXPLAIN` and `EXPLAIN ANALYZE`, optimize them using indexing and query rewriting, and compare execution performance before and after optimization.

## Concepts

- Recursive common table expressions for sample data generation
- Single-column, composite, and covering indexes
- Sargable date range predicates
- `EXPLAIN ANALYZE` performance comparison

## Procedure

1. Create `Customer_Order` and generate 10,000 rows; verify the row count and date range.
2. Run the five `EXPLAIN ANALYZE` queries before optimization.
3. Create the specified indexes and rerun each query; rewrite the `YEAR(Order_Date)` predicate as a date range.
4. Inspect the indexes and compare before/after execution plans and measurements.

## How to run

Run `experiment_10.sql` in MySQL 8.0.18 or later, with permission to create and select the `Experiment10` database. The script drops and recreates `Customer_Order` at the start, so rerunning it resets the sample data. `EXPLAIN ANALYZE` runs each query and reports actual measurements; execution times and access paths depend on the server and its statistics.

The source experiment rewrites the `YEAR(Order_Date)` predicate as a date range but does not create a standalone index on `Order_Date`. The rewrite avoids applying a function to the column; an index on that column would be needed for the range to use an index. The SQL and query sequence otherwise follow the supplied Experiment 10 pages.

## Result

The dataset contains 10,000 orders, with dates from 2026-01-01 through 2026-10-27. The five query pairs compare the stated index/query-rewrite changes; use the `EXPLAIN ANALYZE` results from the target MySQL server for actual measurements.
