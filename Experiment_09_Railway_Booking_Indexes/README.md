# Experiment 9: Railway Booking Indexes

## Aim

To create a Railway Booking table containing at least 5,000 records, benchmark query performance before and after creating single and composite indexes, and compare the execution plans using `EXPLAIN`.

## Concepts

- Recursive common table expressions for generating sample records
- Single-column and composite indexes
- `EXPLAIN` and `EXPLAIN ANALYZE`
- Comparing rows examined and execution time

## Procedure

1. Create `Railway_Booking` and generate 5,000 rows.
2. Verify the record count and run the `Train_No` query before indexing.
3. Create `idx_train_no` and compare the plan and measured execution.
4. Create `idx_train_date` on `(Train_No, Journey_Date)` and inspect the date-range query.
5. Compare the single and composite index plans and record the server's actual timing and row counts.

## How to run

Run `experiment_09.sql` in MySQL 8.0.18 or later, with permission to create and select the `Experiment9` database. `EXPLAIN ANALYZE` executes the query and reports actual measurements; timing and selected access paths depend on the MySQL version, statistics, and host. The script drops and recreates `Railway_Booking` at the start, so rerunning it resets the dataset.

## Result

The table contains 5,000 generated bookings. The script compares the `Train_No` filter before and after a single-column index and compares the train/date range using a composite index. Use the reported `EXPLAIN ANALYZE` measurements from the target MySQL server for the performance comparison.
