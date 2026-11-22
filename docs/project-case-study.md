# Case study: Olympics Database Management System

**Context:** Individual work for ISYS2014, Semester 2 2024, Curtin University.

**Goal:** Build and query an Olympics-related relational database, then integrate database operations with Python.

**What I implemented**

- MySQL schema with ten tables, including primary keys, foreign keys and composite keys.
- Sample data insertion scripts and fourteen retrieval queries using multiple SQL techniques.
- Stored procedures for inserting an athlete/updating a team count, and categorising coaches' experience by country.
- A trigger enforcing a venue-capacity rule, plus a view to simplify access to athlete participation details.
- Python code using `mysql.connector`, environment variables for credentials, query execution, and insert/update/delete operations.

**Tech stack:** MySQL, SQL, Python, mysql-connector-python.

**What it demonstrates:** SQL querying, relational modelling, database-side logic and Python integration.

**Evidence:** `sql/create_tables.sql`, `sql/queries.sql`, `python/connectionDBS.py` in this repository.

**Limitations:** This was coursework with local database data, not a production application. No performance benchmarking, automated testing, or security penetration testing was established by the uploaded files. Some original examples intentionally cause validation errors and should be reviewed before execution.
