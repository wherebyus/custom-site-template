# Dev Environment Bootstrap for WhereBy.Us
(Requires access to a private repo to fully work, but we'll make our instructions public.)

This site bootstrap is designed to be used with [Varying Vagrants Vagrant](varyingvagrantvagrants.org) and frodo, an internal (private) github repo which has our WordPress themes and plugins. 

This documentation was forked from [Code for the People](https://github.com/cftp/vvv-init), now part of Automattic.

# Configuration

### The minimum required configuration:

```
my-site:
  repo: https://github.com/Varying-Vagrant-Vagrants/custom-site-template
  hosts:
    - my-site.test
```
| Setting    | Value        |
|------------|--------------|
| Domain     | my-site.test |
| Site Title | my-site.test |
| DB Name    | my-site      |
| Site Type  | Single       |
| WP Version | Latest       |

### Minimal configuration with custom domain and WordPress Nightly:

```
my-site:
  repo: https://github.com/Varying-Vagrant-Vagrants/custom-site-template
  hosts:
    - foo.test
  custom:
    wp_version: nightly
```
| Setting    | Value        |
|------------|--------------|
| Domain     | foo.test     |
| Site Title | foo.test     |
| DB Name    | my-site      |
| Site Type  | Single       |
| WP Version | Nightly      |

### WordPress Multisite with Subdomains:

```
my-site:
  repo: https://github.com/Varying-Vagrant-Vagrants/custom-site-template
  hosts:
    - multisite.test
    - site1.multisite.test
    - site2.multisite.test
  custom:
    wp_type: subdomain
```
| Setting    | Value               |
|------------|---------------------|
| Domain     | multisite.test      |
| Site Title | multisite.test      |
| DB Name    | my-site             |
| Site Type  | Subdomain Multisite |
| WP Version | Nightly             |

## Configuration Options

```
hosts:
    - foo.test
    - bar.test
    - baz.test
```
Defines the domains and hosts for VVV to listen on. 
The first domain in this list is your sites primary domain.

```
custom:
    site_title: My Awesome Dev Site
```
Defines the site title to be set upon installing WordPress.

```
custom:
    wp_version: 4.6.4
```
Defines the WordPress version you wish to install.
Valid values are:
- nightly
- latest
- a version number

Older versions of WordPress will not run on PHP7, see this page on [how to change PHP version per site](https://varyingvagrantvagrants.org/docs/en-US/adding-a-new-site/changing-php-version/).

```
custom:
    wp_type: single
```
Defines the type of install you are creating.
Valid values are:
- single
- subdomain
- subdirectory

```
custom:
    db_name: super_secet_db_name
```
Defines the DB name for the installation.

### WhereBy.Us Specific

1. If you don't already have it, clone the [Vagrant repo](https://github.com/Varying-Vagrant-Vagrants/VVV) (perhaps into your `~/vagrant-local/` directory, you may need to create it if it doesn't already exist). BE SURE TO USE VERSION 2.0.
2. Install the Vagrant hosts updater: `vagrant plugin install vagrant-hostsupdater`
3. Create a new file, `vvv-custom.yml` with [the content of this gist](https://gist.github.com/ErnieAtLYD/6d98026bc0fc700ff52889a5164b6927) (or [download the file](https://gist.githubusercontent.com/ErnieAtLYD/6d98026bc0fc700ff52889a5164b6927/raw/72edad33227b0e14dec56d7eab0e14321de9dc34/yyy-custom.yml) directly). 
4. If your Vagrant is running, from the Vagrant directory run `vagrant halt`
Followed by `vagrant up --provision`.
5. Go for a walk. The initial provisioning may take a while.
6. To get the latest theme and plugins code, cd into `www/wbu` and run `bash seed.sh` to download these separately.
7. Then you can visit:

http://wbu.test/
