# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html), as much as a document can.

## 2.01

2022-12-31

### Fixed

- `subscriptions.opml` was valid XML and OPML, but contained no `<outline type="rss" />` elements, and so it was not interpreted as containing feeds by some feed readers. This has been fixed.

### Added

- `subscriptions.opml.php` generates a valid OPML file, whose contents are now saved as `subscriptions.opml`
- `README.md` now contains a description of how to update this repository, including instructions on how to use `subscriptions.opml.php`

## 2.0

2022-12-22

### Breaking Changes

- renamed `subscriptions.xml` to `subscriptions.opml`, in order to match file extensions expected by RSS feed readers

### Added

- Added a title to the OPML file
- Added other metadata to the OPML file

## 1.1

2022-12-22

### Added

- Added OPML file as `subscriptions.xml` to ease import into RSS readers. Thanks to https://opml-gen.ovh/ for the generator.

## 1.0

2022-10-06

Initial release, containing a full scrape of the first 1000 GovDelivery feed IDs in the form of a CSV.
