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
    - Rails 6.0.0.rc1.
    - Postgres 9+.
- Install Figaro for DB credentials:
    - bundle exec figaro install
    - Enter the following into the new application.yml:
        ```yml
        development:
            db_username: <username>
            db_password: <password>
        ```

## Deployment

- [Digital Ocean](https://www.digitalocean.com/).
    - $5 Ubunutu Droplet.
- [Setup Ruby on Rails](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04).
- [Setup Puma and Nginx](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04).
- [Setup Automatic Deployment](https://www.digitalocean.com/community/tutorials/how-to-set-up-automatic-deployment-with-git-with-a-vps).

## License

MIT © [Casey Dyer](https://github.com/dyersituations)
