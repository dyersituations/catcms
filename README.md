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
    - Ruby 2.6.3.
    - Rails 6.0.0.rc1.
    - https://gorails.com/setup/ubuntu/19.04.
- Install Figaro for DB credentials:
    - bundle exec figaro install
    - Enter the following into the new application.yml:
        ```yml
        development:
            db_username: <username>
            db_password: <password>
        ```

## Deployment

Details on setting up the server and deploying the site coming soon!

## License

MIT © [Casey Dyer](https://github.com/dyersituations)