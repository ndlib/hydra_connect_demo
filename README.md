# HydraConnectDemo

[![Build Status](https://travis-ci.org/ndlib/hydra_connect_demo.png?branch=master)](https://travis-ci.org/ndlib/hydra_connect_demo)
[![Code Climate](https://codeclimate.com/github/ndlib/hydra_connect_demo.png)](https://codeclimate.com/github/ndlib/hydra_connect_demo)
[![Coverage Status](https://img.shields.io/coveralls/ndlib/hydra_connect_demo.svg)](https://coveralls.io/r/ndlib/hydra_connect_demo)
[![API Docs](http://img.shields.io/badge/API-docs-blue.svg)](http://rubydoc.info/github/ndlib/hydra_connect_demo/master/frames/)
[![APACHE 2 License](http://img.shields.io/badge/APACHE2-license-blue.svg)](./LICENSE)

## Development

Database Seeds for:

- [X] Register work types:
  - [X] Document
  - [X] Article
- [X] Register predicates
  - [X] Title
  - [X] Abstract
  - [ ] File
- [X] Associate work types and predicates

Application:

- [X] UI for chosing which work type to create
- [X] UI for entering a new work
  - [X] Multi-file upload
  - [X] With user input pre-loading the form
  - [X] Multiple predicates
  - [X] Persist data even though it is not valid
- [X] UI response upon creation of a new work
  - [ ] BONUS: Display informational messages
  - [X] Redirect to a location
- [X] UI for showing an uploaded work
  - [X] Link to each of the files
    - [X] Resolve link to download action
    - [X] Render the attachment name
  - [X] Display each of the predicates
  - [X] A button to edit the work
    - [ ] BONUS: Button is rendered based on state of object
- [X] UI for editing a new work
  - [X] Append new files
  - [X] With user input to append values to predicates
  - [X] Remove existing files
  - [X] Show existing files
    - [X] Render the attachment name
    - [X] Render link to attachment
  - [X] Modify predicate values
- [X] Swap out Database persistence of works for Fedora persistence
  - [ ] BONUS: Enable creation of attachments for Fedora persistence
- [ ] BONUS: Move data from Database to Fedora
- [X] UI response upon update of an existing work
  - [ ] BONUS: Display informational messages
  - [X] Redirect to a location
- [X] Meaningful JSON document for /works/article/new
  - [ ] BONUS: Better than meaningful. Something deliberate and useful.
- [X] Amend an existing Work Type via the UI
  - [X] Determine why Active Admin is not behaving correctly when updating
  - [X] Add a new predicate to the work type
    - [X] Edit an existing work of the given type to show new predicate
  - [X] Remove an existing predicate from a work type
    - [X] Show an existing work of the given type to show predicate is still displayed
    - [X] Edit an existing work of the given type to show predicate is still editable
  - [ ] BONUS: Add a custom show partial for a work type
  - [ ] BONUS: Add a custom show partial for a property set
  - [ ] BONUS: Add a custom show partial for a property
- [X] Leverage Translations
  - [X] For work type name
  - [X] For predicate label and hints
  - [X] For fieldset legend
  - [ ] BONUS: For informational messages

## Resources

* [Contributing Guidelines](./CONTRIBUTING.md)
* [Test related README](./spec/README.md)
