# Experiment 8: Transactions and Isolation

## Aim

To implement banking-style transactions using `BEGIN`, `COMMIT`, `ROLLBACK` and `SAVEPOINT`, simulate partial transaction failures, and demonstrate isolation levels and concurrency anomalies using two database sessions.

## Concepts

- Transaction commit and rollback
- Savepoints and partial rollback
- InnoDB transactions and isolation levels
- Dirty reads, non-repeatable reads, and phantom reads

## Procedure

1. Create the `Bank_Account` and `Transaction_Log` tables and insert the three initial accounts.
2. Commit a successful transfer, roll back a transfer to a nonexistent account, and demonstrate partial rollback to a savepoint.
3. Use two MySQL sessions to demonstrate a dirty read at `READ UNCOMMITTED`.
4. Use two sessions at `READ COMMITTED` to demonstrate a non-repeatable read and a phantom read.
5. Compare the current transaction isolation values at each isolation level.

## How to run

Use MySQL 8.0+ with InnoDB and permission to create the `Experiment8` database. Run the setup and transaction sections of `experiment_08.sql` in one MySQL session. The concurrency demonstrations are marked by session number in the script: pause at each instruction, run the corresponding block in a second MySQL session, then return to the first session. Roll back Session 1 after the dirty-read demonstration. The script drops and recreates its two tables at the start, so rerunning it resets the data.

## Result

The successful transfer is committed, the failed transfer is rolled back, and the savepoint keeps only the intended partial transfer. The two-session demonstrations show a dirty read, a non-repeatable read, and a phantom read under the specified isolation levels.
