[![Code Climate](https://codeclimate.com/github/andela-mogala/shot/badges/gpa.svg)](https://codeclimate.com/github/andela-mogala/shot)
[![Test Coverage](https://codeclimate.com/github/andela-mogala/shot/badges/coverage.svg)](https://codeclimate.com/github/andela-mogala/shot/coverage)
[![Build Status](https://travis-ci.org/andela-mogala/shot.svg?branch=master)](https://travis-ci.org/andela-mogala/shot)

# TURBO-URL
A url shortener that lives on herooku. Created after the order of popular url shorteners like [Bitly](bit.ly), [Tinyurl](tinyurl.com) and [Google shortener](goo.gl). Turbo-url allows you to provide a valid url and shortens that url with a unique slug. It functions by redirecting visitors of the shortened url to the original url and keeping count of the number of hits the link has amassed.

## FEATURES
|FEATURE                |VISITOR  | REGISTERED USER |
|:----|:---------:|:-----------------:|
|shorten with slug      | NO      |   YES           |
|shorten without slug   | YES     |   YES           |
|view influential users | YES     |   YES           |
|view popular links     | YES     |   YES           |
|view url statistics    | NO      |   YES           |
|delete url             | NO      |   YES           |
| modify url original link| NO    |   YES |
| modify url slug |   NO  | YES |
|disable link | NO |  YES |



## DEPENDENCIES
Turbo-url is built with Ruby on Rails framework. Other important gems include 
* ruby 2.3.0
* rails 4.2.7.1
* bcrypt 3.1 - for authentication
* browser - for extracting client browser details
* bootstrap-sass 3.3 - for UI
* jQuery-rails - for a bit of DOM manipulation

## GETTING STARTED
You can simply visit [turbo-url.herokuapp.com](http://turbo-url.herokuapp.com). Then feel free to provide any long url and watch the app return you a shortened version. However to effectively take charge of the behaviour of the links you provide, you should sign up on the app. This gives you extra abilities like being able to disable a link or even edit the original url or the slug.

### DEVELOPER NOTES
Feel free to clone the app and play around with it on your local machine.
```
git clone git@github.com:andela-mogala/shot.git
```
To get the app running on your local machine, change directory to the root of the application:
```
cd shot
```
Install all dependencies:
```
bundle install
```
Set up the database:
```
rake db:setup
```
You may need to prepend `bundle exec` to the rake command. It would look something like this:
```
bundle exec rake db:setup
```
Finally start the server:
```
rails server -p 3001
```
Be careful to start the server on port 3001 because that is the default port the app has been configured to work with. You may run into problems if you use a different port.


Contributions are also welcome.


##TESTING
The app has been extensively tested to ensure that all the features work as intended. However, there are chances that something may go wrong.Do not hesitate to raise an issue on the github page if you encounter any. That said, if you are interested in viewing the tests and test results, you can simple run:
```
rspec spec/
```
to view all the test results. Or
```
rspec spec/models/
```
to view the model specs. 
```
rspec spec/controllers/
```
to view the controller specs. And
```
rspec spec/features
```
to see the feature specs.


## LIMITATIONS
* The app isn't able to verify if a supplied url actually exists
* No public API for consumption
* Due to the fact that the app is hosted on heroku, sometimes the shortened url could be longer than the original url (lol).

## LICENSES
You are free to do whatever you feel like with the app.
