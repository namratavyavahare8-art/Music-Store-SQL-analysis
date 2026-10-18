                  <u>**MUSIC STORE SQL ANALYSIS**</u>

## PROJECT OVERVIEW

This project uses SQL to explore a music-store database. It analyzes employee hierarchy, customer purchases, invoices, tracks, albums, and artist sales using joins, aggregate functions, subqueries, and sorting.

The database schema includes 11 tables such as `employee`, `customer`, `invoice`, `invoice_line`, `track`, `album`, `artist`, `genre`, and playlist-related tables.


## OBJECTIVES

- Identify the most senior employee by job title.
 
- Find the country with the most invoices.
 
- Identify the highest-spending customer.
 
- List customers who listen to Rock music.
 
- Explore tracks, albums, and artists.

- Find tracks priced above the average track price.

- Summarize artist catalog size and sales revenue.


## TOOLS AND SQL CONCEPTS

- SQL (MySQL-style syntax)
- Relational joins
- `GROUP BY` and aggregate functions
- Subqueries
- `COUNT(DISTINCT ...)`
- `COALESCE`
- Sorting and limiting results


## ANALYSIS AND FINDINGS

### 1. Senior-most employee by job title

The query groups employees by name and title and uses `MAX(levels)` to identify seniority.

### 2. Country with the most invoices

Invoices are grouped by `billing_country`, sorted by invoice count, and limited to the top result.

### 3. Highest-spending customer

Customer records are joined to invoices, and invoice totals are summed per customer.

### 4. Rock music listeners

The query joins customers to invoices, invoice lines, tracks, and genres, then filters for the Rock genre. It returns distinct customer names and email addresses, ordered by email.

This query provides a contact list of customers who purchased Rock tracks.

### 5. Track, album, and artist listing

Tracks are joined to their albums and artists to display each track alongside its album title and artist name.

This is useful for exploring the catalog and checking relationships between tracks, albums, and artists.

### 6. Number of tracks per album

Tracks are grouped by album title and counted.

### 8. Artist catalog and sales summary

The final query reports, for each artist:

- Artist name
- Number of distinct albums
- Number of distinct tracks
- Total sales revenue

The results are ordered from highest to lowest revenue.

> Revenue is calculated as `unit_price * quantity` from invoice lines. The query uses `COALESCE` so artists with no matching sales return zero rather than `NULL`


## NOTES AND LIMITATIONS

- Findings reflect the dataset used when the queries were run.
- 
- Currency values are reported in the database’s stored units; no currency conversion is applied.
- 
- The artist revenue query joins several one-to-many relationships. Validate totals against invoice-line data to ensure joins do not unintentionally duplicate revenue.
- 
- The employee seniority query depends on how the levels field is encoded and ordered.


## CONCLUSION

This project demonstrates how SQL can be used to answer practical business questions from a relational music-store database. The analysis covers customer behavior, invoice distribution, catalog structure, employee hierarchy, and artist revenue.