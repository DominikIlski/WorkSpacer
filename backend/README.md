# 🚀 Getting started with Strapi

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/developer-docs/latest/developer-resources/cli/CLI.html) (CLI) which lets you scaffold and manage your project in seconds.

### `develop`

Start your Strapi application with autoReload enabled. [Learn more](https://docs.strapi.io/developer-docs/latest/developer-resources/cli/CLI.html#strapi-develop)

```
npm run develop
# or
yarn develop
```

### `start`

Start your Strapi application with autoReload disabled. [Learn more](https://docs.strapi.io/developer-docs/latest/developer-resources/cli/CLI.html#strapi-start)

```
npm run start
# or
yarn start
```

### `build`

Build your admin panel. [Learn more](https://docs.strapi.io/developer-docs/latest/developer-resources/cli/CLI.html#strapi-build)

```
npm run build
# or
yarn build
```

## ⚙️ Deployment

### Prerequires
* heroku CLI

Changes to structute of the strapi db start server locally
and make changes there.

After that login to heroku with
`cd ./backend`

`heroku login`

`git add .`

`git commit -m "<commit msg>"`

`git push heroku HEAD:main`

wait for server to rebuild

Strapi should be available at
`https://work-spacer.herokuapp.com/`

### Adding Data

To add data enter
`https://work-spacer.herokuapp.com/`
login to an admin account and add data there


### Using API

Strapi API will be available at 
`https://work-spacer.herokuapp.com/api/<content-type-name>`
Remember to add `s` at the end of name of ct while making a request
and to add API KEY as Bearer Token, that can be generated in settings tab