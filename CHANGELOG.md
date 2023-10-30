# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1] - 2023-09-20 - Hydrogen Aardvark

This is an initial development release for the kick-off of the MC2 Digital Pathology QC supplement (NIH grant number 3U24CA274494-02S2)[https://reporter.nih.gov/search/ONzQ0UoaEUyMrZ2_l6U_yw/project-details/10841333].

### Added

- Initial wrapper of HistoQC
- Docker container
- Samplesheet
- Configs including `test`
- Schema
- Output format same as pure HistoQC
- GH actions to build docker image, scan image, and require sucessful workflow test run for PRs.
