# IT-volunteer #
**Author URI:** http://progress-engine.ru

**Requirements:**
* Any rdbms supported AR
* Sphinx

**License:** GPLv2 or later

**License URI:** http://www.gnu.org/licenses/gpl-2.0.html

**Copyright (C)** 2013 by Teplitsa of Social Technologies (http://te-st.ru)

## Description ##

Social network for altruists.

**Follow this plugin on [GitHub](https://github.com/Teplitsa/IT-volunteer)**

**Localisation**

1. Russian

## Installation ##

* Create database.yml and settings.yml
* Create database `rake db:create && rake db:migrate && rake db:seed`
* Load test data `rake grab:tasks `
* Create index `rake ts:rebuild`
* Start the server `rails s`

## Changelog ##

### 1.0###

* First offical release!
