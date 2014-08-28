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
  - [ ] Multi-file upload
  - [X] With user input pre-loading the form
  - [X] Multiple predicates
- [ ] UI response upon creation of a new work
  - [ ] Display informational messages
  - [X] Redirect to a location
- [ ] UI for showing an uploaded work
  - [ ] Link to each of the files
  - [X] Display each of the predicates
  - [ ] A button to edit the work
    - [ ] BONUS: Button is rendered based on state of object
- [ ] UI for editing a new work
  - [ ] Append new files
  - [ ] With user input to append values to predicates
  - [ ] Remove existing files
  - [ ] Modify predicate values
- [ ] UI response upon update of an existing work
  - [ ] Display informational messages
  - [ ] Redirect to a location
- [ ] Amend an existing Work Type
  - [ ] Add a new predicate to the work type
    - [ ] Edit an existing work of the given type to show new predicate
  - [ ] Remove an existing predicate from a work type
    - [ ] Show an existing work of the given type to show predicate is still displayed
    - [ ] Edit an existing work of the given type to show predicate is still editable
  - [ ] Add a custom show partial for a work type
  - [ ] Add a custom show partial for a property set
  - [ ] Add a custom show partial for a property
- [ ] Leverage Translations
  - [X] For work type name
  - [ ] For predicate label and hints
  - [X] For fieldset legend
  - [ ] For informational messages

## Resources

* [Contributing Guidelines](./CONTRIBUTING.md)
* [Test related README](./spec/README.md)
