# Dev Environment Bootstrap for WhereBy.Us
(Requires access to a private repo to fully work, but we'll make our instructions public.)

This site bootstrap is designed to be used with [Varying Vagrants Vagrant](varyingvagrantvagrants.org) and a private github repo we host called `son-of-frodo` (long story) which has our WordPress themes and plugins. This was forked from [Code for the People](https://github.com/cftp/vvv-init), now part of Automattic.

To get started:

1. If you don't already have it, clone the [Vagrant repo](https://github.com/Varying-Vagrant-Vagrants/VVV) (perhaps into your `~/vagrant-local/` directory, you may need to create it if it doesn't already exist). BE SURE TO USE VERSION 2.0.
2. Install the Vagrant hosts updater: `vagrant plugin install vagrant-hostsupdater`
3. Create a new file, `vvv-custom.yml` with [the content of this gist](https://gist.github.com/ErnieAtLYD/6d98026bc0fc700ff52889a5164b6927) (or [download the file](https://gist.githubusercontent.com/ErnieAtLYD/6d98026bc0fc700ff52889a5164b6927/raw/72edad33227b0e14dec56d7eab0e14321de9dc34/yyy-custom.yml) directly). 
4. If your Vagrant is running, from the Vagrant directory run `vagrant halt`
Followed by `vagrant up --provision`.
5. Go for a walk. The initial provisioning may take a while.
6. To get the latest theme and plugins code, cd into `www/wbu` and run `bash seed.sh` to download these separately.
7. Then you can visit:


http://wbu.dev/


### To-Do
- [ ] Add a way to import the SQL 
- [ ] Import a better WP Engine build script
