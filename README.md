# Chef Nginx Mini Project

A small hands-on Chef Infra project that automatically configures an Ubuntu server with Nginx.

## What it does

Chef will:

1. Install Nginx
2. Create a custom web page
3. Configure Nginx
4. Enable and start Nginx
5. Restart Nginx when the configuration changes

## Project structure

```text
chef-nginx/
├── cookbooks/
│   └── webserver/
│       ├── attributes/
│       │   └── default.rb
│       ├── recipes/
│       │   └── default.rb
│       ├── templates/
│       │   └── default/
│       │       └── index.html.erb
│       └── metadata.rb
└── README.md
```

## Requirements

- Ubuntu 22.04 or 24.04
- sudo access
- Internet access
- Chef Infra Client

## Install Chef Infra Client

On the Ubuntu VM:

```bash
curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef
```

Check:

```bash
chef-client --version
```

## Run the cookbook

Clone/copy this project to the Ubuntu VM, then:

```bash
cd chef-nginx
sudo chef-client --local-mode --runlist 'recipe[webserver]' --cookbook-path ./cookbooks
```

You should see Chef install/configure Nginx.

## Test

Find the VM IP:

```bash
hostname -I
```

Then open:

```text
http://YOUR_VM_IP
```

You should see:

> Hello from Chef!

## Run Chef again

Run the same command:

```bash
sudo chef-client --local-mode --runlist 'recipe[webserver]' --cookbook-path ./cookbooks
```

The second run should make little or no changes. This demonstrates Chef's **idempotency**.

## Change the page

Edit:

```text
cookbooks/webserver/templates/default/index.html.erb
```

For example:

```html
<h1>Hello from Chef!</h1>
<p>This server is managed by Chef.</p>
```

Change the text, run Chef again, and refresh the browser.

## Change the server name

Edit:

```text
cookbooks/webserver/attributes/default.rb
```

Then change:

```ruby
default['webserver']['title'] = 'Chef Managed Server'
```

Run Chef again.

## Useful commands

Check Nginx:

```bash
systemctl status nginx
```

Test configuration:

```bash
sudo nginx -t
```

View the page:

```bash
curl http://localhost
```

View Chef logs:

```bash
sudo chef-client --local-mode --runlist 'recipe[webserver]' --cookbook-path ./cookbooks -l info
```

## Next steps

After this works, extend the project with:

- a custom Nginx virtual host
- firewall configuration
- application deployment
- environment-specific attributes
- multiple recipes
- a Chef role
- Test Kitchen
- Chef Server / Policyfiles
