# Documentation Builder

This container implements a process for gathering and packaging data documentation for the EPA ECHO data we are bringing into the EEW cache. We attempt to pull in formal, structured metadata for source data wherever possible, and resort to web scraping or other parsing methods when necessary. The end target is a suite of [JSON Schema](https://json-schema.org) documents that can be used to share descriptive information for human consumption or applied with tools to run data validation tests.