# Review and safety notes

## Verified directly from the supplied ZIP

- Six files were present: five `.sql` files and one `.py` file.
- The SQL schema contains ten `CREATE TABLE` statements.
- The query script contains fourteen documented SELECT examples, two stored procedures, one trigger and one view.
- The Python file contains fourteen SELECT operations plus parametrised insert, update and delete statements.
- The Python file parses successfully as valid Python syntax.
- MySQL credentials are retrieved from `DBS_USER` and `DBS_PASS` rather than hard-coded in Python.

## Not verified

- MySQL execution was **not performed**; successful runtime execution or all database constraints cannot be guaranteed.
- The original dataset's reuse and public redistribution permissions are unknown.
- Data quality, performance, security posture and production suitability were not assessed.

## Important limitations and cautions

- `create_database.sql` uses `DROP DATABASE IF EXISTS` and is destructive if run against an existing database of that name.
- `queries.sql` contains a purposely rejected venue-capacity update (35,000) as a trigger demonstration; an error is expected.
- `run_all_scripts.sql` assumes the database already exists and uses MySQL CLI `SOURCE` commands relative to the working directory.
- `connectionDBS.py` writes database changes, so running it repeatedly can insert duplicate primary keys.
- The bulk data is coursework sample data and should remain private until permissions to republish are confirmed.

## Portfolio modifications

- Removed student ID and student name header comments.
- Renamed `OlympicsDBS_22001797` to `OlympicsDBS_Portfolio` consistently across scripts.
- Reorganised files into `sql/` and `python/`; added documentation and `.gitignore`.
- The original uploaded ZIP has not been overwritten.
