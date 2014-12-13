#Clndr Rails
Simple way to insert calendar view into your rails app
This gem based on [CLNDR.js](http://kylestetz.github.io/CLNDR/)

##Features

##Instalation
For basic usage just include clndr-rails gem:

```
gem 'clndr-rails'
```
then run

```
bundle install
```

##Usage
Include clndr-rails javascripts and dependency libraries in your `app/assets/javascripts/application.js`:

```
//= require jquery
//= require moment
//=require underscore
//=require clndr-rails

```
##i18n
You can internationalize yours calendars by include moment.js locale file

 ```
 //=require moment/ru
 ```
 Now date format will be for Russian

This project rocks and uses MIT-LICENSE.