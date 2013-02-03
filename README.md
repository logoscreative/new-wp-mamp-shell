New MAMP WordPress Install via Shell
=================

Roll a new WordPress installation for MAMP with this quick shell script (allows custom inputs for directory, database name, and WP version).

Assuming you have MAMP installed in `/Applications/MAMP/htdocs`:

1. Download the shell script.
1. Run it in Terminal.
1. Answer the prompts.

From my <a href="http://logos-creative.com/roll-a-new-mamp-wordpress-install-quickly-with-this-shell-script/" target="_blank">brief write-up</a>:

> I decided to combine the most common, repetitive steps of the process into one useful shell script that:

> 1. Creates a new directory (and lets me name it)
> 1. Downloads WordPress from GitHub and checks out whatever version I tell it to
> 1. Creates a new database (and lets me name it) and gives the MySQL user proper permissions
> 1. Generates my <a href="http://codex.wordpress.org/Editing_wp-config.php#Security_Keys" target="_blank">security keys</a> and adds them to `wp-config.php`
> 1. Adds my database name, username, and password to `wp-config.php`
> 1. Opens up `wp-admin/install.php` to lets me complete installation

FAQ
-----------------

Getting _fatal: could not create work tree dir..._ or having other permissions-related issues? Put `sudo` in front of the path to the script before running it.
