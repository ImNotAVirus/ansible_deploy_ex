# Phoenix Deployment with Ansible

> This repository contains Ansible playbooks to prepare and deploy a Phoenix/Elixir server in production.

## Installation

```sh
# 1. Clone the repository
git clone https://github.com/ImNotAVirus/ansible_deploy_ex deploy
cd deploy

# 2. Copy and configure example files
cp playbooks/inventory/hosts.example playbooks/inventory/hosts
cp playbooks/group_vars/all/all.yml.example playbooks/group_vars/all/all.yml
# Edit these files to match your application, server, domain, and SSH key

# 3. Run the Ansible playbooks (replace `3333` with the configured port in `ssh_port`)
ansible-playbook playbooks/setup.yml
ansible-playbook playbooks/deploy.yml -e ansible_port=3333

```

### Optional: Deploy with `mix deploy`

You can add a `deploy` alias in your `mix.exs`:

```elixir
defp aliases do
  [
    # ...other aliases...
    deploy: [
      "cmd cd deploy && ansible-playbook playbooks/deploy.yml -e ansible_port=3333"
    ]
  ]
end
```

With this alias, simply run `mix deploy` to deploy your application in production (replace `3333` with your SSH port if needed).

## `playbooks/setup.yml` — Server Preparation & Hardening

- Prepares the server with required packages and security best practices.
- Sets up a secure user, SSH access, and basic firewall/hardening.
- Installs and configures Nginx and SSL (via Certbot) for serving your application.

## `playbooks/deploy.yml` — Build & Application Deployment

- Builds your Phoenix/Elixir application for production.
- Deploys the release and environment files to the server and restarts the app.

## Roles structure

- `base`: Basic system preparation.
- `harden_server`: Server hardening and security.
- `setup_nginx`: Nginx and Certbot installation/configuration.
- `build_release`: Phoenix release build.
- `deploy_release`: Release deployment to the server.

## License

This project is licensed under the MIT License.
