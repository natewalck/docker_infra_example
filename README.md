# Personal Cloud IaC

This is the repo I use for my personal home media server, hosted as a VPS. This draws heavily from [Funky Penguin's Geek Cookbook](https://geek-cookbook.funkypenguin.co.nz/), but uses a single node rather than a swarm and is targeted against Traefik 2.

## Services

- Traefik load balancer, with dashboard protected by Organizr.
- Organizr IDM, launcher and ACLs for access to your server.
- Portainer management console.
- dozzle for logs and troubleshooting.
- PiHole for internal DNS and Ad blocking for you home network.

## Deploying a new service

Services each live in their own directory, and are driven primarily by a `docker-compose.yml` file. The `example` directory includes several configuration options that can be used to design other services.

#### Environment variables

##### `CLOUD_ENV`

This is either `prod` or `dev`. Its primary use is changing the overrides file: `docker-compose.$CLOUD_ENV.yml`, but it's also available for use in the environment.

##### `BASE_DOMAIN`

This is the main domain that all services are rooted at. They will become subdomains under this.

##### `DATA_DIR`

This is a local path that can be used for persistent volumes. Best practice is for each stack to create volumes under a directory matching the stack name, so for example `${DATA_DIR}/myapp/`.

##### `MEDIA_DIR`

This is a local path that can be used for persistent volumes. Best practice is for each stack to reuse/share the MEDIA_DIR for media, so for example: `${MEDIA_DIR}/TV/`,`${MEDIA_DIR}/Movies/`,`${MEDIA_DIR}/Downloads/`.

## Starting from scratch

The following process is necessary to "bootstrap" a machine.

1. Set up the environment variables:

   1. `CLOUD_ENV` to either `dev` or `prod`.
   2. `BASE_DOMAIN`, `DATA_DIR`, and `MEDIA_DIR` based on your configuration.

2. Create the traefik network.

   `docker network create traefik`

3. Start the traefik service.

   `./compose.sh traefik up -d`

4. Start Oganizr.

   `./compose.sh oganizr up -d`

5. Setup `oganizr.$BASE_DOMAIN` and/or your http://ip:9983

6. Setup accounts, service tabs, etc. via the webUI. More info can be found on the official Organizr(https://github.com/causefx/Organizr/GitHub) repository.
   - https://docs.organizr.app/books/installation/page/first-time-setup

7. Setup SSO 

   - https://docs.organizr.app/books/setup-features/page/plex-authentication

8. Start a new apple by cloning example, as new app name, replacing 'simple' for 'app name'.

9. Configure app_name/docker-compose.prod.yaml.
   - be sure to read the comments and update each of settings for your app

9. Start new app.
   `./compose.sh app_name/ up -d`
