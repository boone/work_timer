# Work Timer

Rails 5.2 project, used to track time worked on projects for a single user.

![Build Status](https://travis-ci.org/boone/work_timer.svg?branch=main)

## Setup

* git clone git://github.com/boone/work_timer.git
* cd work_timer
* bundle
* rails db:migrate
* Set your time zone in config/application.rb
* rails s
* Visit http://localhost:3000
* Create a new client and project, then click New Event to start tracking your time
* Visit a client page and click Weekly or Monthly to view reports

It also works well on a Mac using the Pow server (http://pow.cx).

This app was meant to be run locally on a development system. If you intend to run it on the web,
you should use your own database.yml and secrets.yml. And add your own authentication layer.

## Contact

http://boonedocks.net

[@boonedocks](https://twitter.com/boonedocks) on Twitter
