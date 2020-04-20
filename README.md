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
    - $5 Ubunutu Droplet
- [Server Setup](https://gorails.com/deploy/ubuntu/18.04)
  - If an earlier version of bundler installs:
    - ```gem install bundler -v 2.0.1```
    - Firewall setup:
      - ```sudo ufw allow OpenSSH```
      - ```sudo ufw allow 80/tcp```
      - ```sudo ufw allow 443/tcp```
- Capistrano deployment:
  - ```bundle exec cap production deploy```
- More to come:
  - Domain
  - SSL Certificate
  - Log Rotation

## License

MIT © [Casey Dyer](https://github.com/dyersituations)
