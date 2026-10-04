# Chef-Nginx-Lab

A small Chef Infra project that configures an Ubuntu server with Nginx, using `chef-client` in local mode (no Chef Server needed).

## What it does

The `webserver` cookbook:

1. Installs Nginx
2. Creates the web document root
3. Renders a custom `index.html` from a template
4. Enables and starts the Nginx service

## Project structure

```text
Chef-Nginx-Lab/
├── cookbooks/
│   └── webserver/
│       ├── attributes/default.rb
│       ├── recipes/default.rb
│       ├── templates/default/index.html.erb
│       └── metadata.rb
└── README.md
```

## Requirements

- Ubuntu server (tested on Ubuntu 26.04)
- `sudo` access and internet access
- Chef Infra Client

## Install Chef Infra Client

```bash
curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef
chef-client --version
```

## Usage

Refresh the package index, then run Chef from the repo root (the directory that contains `cookbooks/`):

```bash
sudo apt-get update
cd Chef-Nginx-Lab
sudo chef-client --local-mode --runlist 'recipe[webserver]' --chef-license accept
```

Short form: `sudo chef-client -z -o 'recipe[webserver]'`

> `chef-client` has no `--cookbook-path` flag. In local mode it automatically uses `./cookbooks`.

## Test

```bash
curl http://localhost
```

Or open `http://YOUR_SERVER_IP` in a browser (find the IP with `hostname -I`, and make sure port 80 is open in your security group).

## Idempotency

Run the same command a second time. Chef should report few or no changes, because the server is already in the desired state.

## Customize

| What | Where |
|------|-------|
| Page content | `cookbooks/webserver/templates/default/index.html.erb` |
| Attributes (e.g. document root) | `cookbooks/webserver/attributes/default.rb` |
| Resources and order | `cookbooks/webserver/recipes/default.rb` |

After any change, run Chef again.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `invalid option: --cookbook-path` | Remove the flag and run from the repo root |
| `apt-get` exits with `100` / 404 Not Found | Run `sudo apt-get update`, then re-run Chef |
| `cookbook not found` | Check that `cookbooks/webserver/metadata.rb` exists and you are in the repo root |
| Nil error on `document_root` | Define `default['webserver']['document_root']` in the attributes file |

Useful commands:

```bash
systemctl status nginx    # service status
sudo nginx -t             # test Nginx config
sudo chef-client -z -o 'recipe[webserver]' -l info   # verbose logs
```

## Next steps

- Custom Nginx virtual host (with `notifies :restart`)
- Firewall configuration
- Multiple recipes and roles
- Test Kitchen
