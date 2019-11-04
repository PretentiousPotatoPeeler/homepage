---
title: "How I Setup This Blog"
date: 2019-05-10T11:56:20+02:00
---

When I decided my life needed a personal blog, I also decided that I wanted it to be as little of a hassle as humanly possible. I had read a little about static websites and thought that might work. I'm using [Hugo](http://gohugo.io) for my static site generation. I was also already using [Caddy](http://caddyserver.com) for another project so I wanted to reuse that. 

# Hugo Blog
To setup the Hugo blog, I used the following command:
```bash
hugo new site homepage
```
This generates a blank website. To fancy it up a little, I used the [Kiera](https://github.com/avianto/hugo-kiera) theme:
```bash
cd themes
git clone https://github.com/avianto/hugo-kiera kiera
```
I copied the `config.toml` from the Kiera [exampleSite](https://github.com/avianto/hugo-kiera/tree/master/exampleSite) directory and changed it to my needs.

For new blog posts I can simply use `hugo new content/post/<blogpost.md>`. Easy!

# Caddy Setup
The following is an excerpt from the Caddyfile that I use for this blog:
```caddy
https://pbcompaan.tk {
  log /var/log/caddy.blog.log
  errors /var/log/caddy.blog.err 
  root /var/www/blog/dist

  git {
    repo https://github.com/PretentiousPotatoPeeler/homepage.git
    path ../download
    branch master
    then hugo --destination=/var/www/blog/dist
  }
}
```
Super simple really. I use the Caddy [GIT](https://caddyserver.com/v1/docs/http.git) plugin to poll my [Github repo](https://github.com/PretentiousPotatoPeeler/homepage.git). When the clone is done, Caddy runs the hugo command to build the blog.

# Docker Setup
I run Caddy inside a Docker container, using the builder from [abiosoft](https://github.com/abiosoft/caddy-docker). I needed to add the Hugo executable to this container. Got this working by adding the folowing to the `Dockerfile`:
```Dockerfile
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-64bit.tar.gz -O hugo.tar.gz && \
  tar -xzvf hugo.tar.gz && \
  mv hugo /usr/bin/hugo && \
  rm hugo.tar.gz LICENSE README.md
```
This will download the Hugo package from their Github releases and move the executable to the `/usr/bin` directory for easy execution. It also cleans up after itself, just like it's was raised to do. In the future I need to figure out how to stay up to date with the latest Hugo version, but for now this will do!