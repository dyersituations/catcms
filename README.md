## CatCMS
_**C**ool **A**r**t** **C**ontent **M**anagement **S**ystem_

The typical website a visual artist uses to display their work is both expensive to buy and expensive to maintain. CatCMS was born from the desire to create a simple and powerful tool that empowers an artist to both create and maintain their own website. 

This tool can be used to build any simple website without the developer needing to upload any code and without the user needing to know how the website works behind the scenes. Once an instance of CatCMS has been deployed to a server, the developer is entirely hands-off, and the user can take control of the website creation and maintenance.

## Features

- You can create, edit, and delete pages.
- You can change the website title and content.
- You can populate image galleries and blogs.
- You can change the website appearance without writing code.

## Tech Stack

<b>Frontend</b>
- [jQuery](https://jquery.com/)
- [Bootstrap](https://getbootstrap.com/)
- [Lightbox](https://lokeshdhakar.com/projects/lightbox2/)

<b>Backend</b>
- [Ruby on Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)

## Development
- For W10 machines, set up Linux subsystem with Ubuntu: 
  - https://docs.microsoft.com/en-us/windows/wsl/install-win10.
- Setup Rails and PostgreSQL:
  - Ruby 2.6.0.
  - Rails 6.0.0.
  - Postgres 9+.
- Install Figaro for DB credentials:
  - bundle exec figaro install
  - Enter the following into the new application.yml:
      ```yml
      development:
        db_username: <username>
        db_password: <password>
      production:
        db_username: <username>
        db_password: <password>
      ```

## Deployment

- [Digital Ocean](https://www.digitalocean.com/).
    - $5 Ubunutu Droplet.
- [Server Setup](https://gorails.com/deploy/ubuntu/18.04)
  - ```gem install bundler -v 2.0.1```
- [Capistrano::FigaroYml]https://github.com/chouandy/capistrano-figaro-yml
  - ```bundle exec cap production setup```
  - ```bundle exec cap production deploy```
- Firewall.
  - ```sudo ufw allow OpenSSH```
  - ```sudo ufw allow 80/tcp```
  - ```sudo ufw allow 443/tcp```
- Domain
- SSL Certificate
- Log Rotation

## License

MIT © [Casey Dyer](https://github.com/dyersituations)
