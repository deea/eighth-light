# CLI application using Google Books API

A project to perform a book search on Google Books API and add books to a local list following the results with a CLI

## General information about the design and assumptions

For this programme I have created one main class, the Book class and an interface file.

When the application is launched in the CLI, the user is prompted to enter a letter describing the action they would like to take: list books, add books or quit.

Based on the user's response captured, the Book class methods are applied as they are being called.

## Getting started

To run this project, save it locally, open a CLI and make sure ruby is installed. Once installation completes, you will be able to interact with the application:

1. Check if you have ruby, in the terminal type ruby -v
2. If you don't have it installed, visit the ruby installation documentation by following the link and indicated steps `https://www.ruby-lang.org/en/documentation/installation/`
3. Run `ruby lib/interface.rb`
4. You will be prompted to enter the letter to begin an action of your choice

### Actions

* l = list your saved books
* a = search for and add a new book
* q = quit

## Technologies

Project created with:

* ruby: ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
* RSpec 3.9
  - rspec-core 3.9.0
  - rspec-expectations 3.9.0
  - rspec-mocks 3.9.0
  - rspec-support 3.9.0

## Running tests

* Ensure RSpec is installed `gem install rspec`
* You can run tests with the following command when in the root folder of the project: `rspec ./spec/models/book_spec.rb`