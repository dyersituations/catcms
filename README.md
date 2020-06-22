## CatCMS
_**C**ool **A**r**t** **C**ontent **M**anagement **S**ystem_

The typical website a visual artist uses to display their work is both expensive to buy and expensive to maintain. CatCMS was born from the desire to create a simple and powerful tool that empowers an artist to both create and maintain their own website. 

This tool can be used to build any simple website without the developer needing to upload any code and without the user needing to know how the website works behind the scenes. Once an instance of CatCMS has been deployed to a server, the developer is entirely hands-off, and the user can take control of the website creation and maintenance.

## Features

- You can create, edit, and delete pages
- You can change the website title and content
- You can populate image galleries and blogs
- You can change the website appearance without writing code

## Tech Stack

<b>Frontend</b>
- [jQuery](https://jquery.com/)
- [Bootstrap](https://getbootstrap.com/)
- [Lightbox](https://lokeshdhakar.com/projects/lightbox2/)

<b>Backend</b>
- [Ruby on Rails](https://rubyonrails.org/)
- [SQLite](https://www.sqlite.org/index.html)

## Development
- For W10 machines:
  - [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
  - [VSCode](https://code.visualstudio.com/)
  - Open app folder in WSL
- Setup Rails:
  - Ruby 2.6.0
  - Rails 6.0.0

## Deployment

- [Digital Ocean](https://www.digitalocean.com/)
    - $5 Ubuntu Droplet for a small website
- [Server Setup](https://gorails.com/deploy/ubuntu/18.04)
  - Install image editor for CarrierWave
    - ```cd /home/deploy```
    - ```sudo apt-get install imagemagick libmagickwand-dev```
  - Capistrano:
    - Create shared sqlite3 DB:
      - ```mkdir /home/deploy/shared```
      - ```scp development.sqlite3 deploy@x.x.x.x /home/deploy/myapp/shared/production.sqlite3```
    - ```cap production deploy```
  - [Log Rotation](https://gorails.com/guides/rotating-rails-production-logs-with-logrotate)
    - Access the site between manual logrotate commands to see expected log items
  - [SSL Certification](https://gorails.com/guides/free-ssl-with-rails-and-nginx-using-let-s-encrypt)
- More to come:
  - Domain

## License

MIT © [Casey Dyer](https://github.com/dyersituations)
