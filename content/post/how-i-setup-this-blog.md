---
title: "How I Setup This Blog"
date: 2019-05-10T11:56:20+02:00
draft: true
---

When I decided my life needed a personal blog, I also decided that I wanted it to be as little of a hassle as humanly possible. I had read a little about static websites and thought that would work. I was also already using Caddy for another project so I wanted to reuse that. 

## Stack
After a short Google search I ended up with this stack:

1. **AWS EC2**  
Running this on an EC2 instance seemed like the easiest solution. I'd have full control of the setup and I could reuse my existing Caddy setup.

1. **Caddy**  
[Caddy](caddy) is awesome. By far the easiest setup I've ever used.

1. **Hugo**  
[Hugo](hugo) looked like a straight forward way to go. Flexible enough for when I wanted to get creative but also easy to use and lightweight. 

## The good stuff
So lets get into the actual setup!

### Caddy
After setting up caddy on the EC2 instance *(TODO: Blog reference)*, I used the following config the publish the Hugo project

```
blog.pbcompaan.tk {
  root /www/blog
  gzip
  log /var/log/caddy/blog.access.log
  git github.com/PretentiousPotatoPeeler/homepage {
    path /tmp/homepage
    then_long ./build.sh /www/blog
    interval 120
  }
}
```


