# Test how nginx loadbalancers behaves when host goes down

Start env

```# docker-compose up -d```

Start checking

```# ./check.sh```

Simulate failure

```# docker-compose stop web1```

# Conclusion
Nginx will passively monitor backend health as requests are made. By default, ```proxy_connect_timeout``` is ```60s``` and ```fail_timeout``` on the server is ```10s```. This means that a connection is stalled for 60s before nginx determines the backend is dead. After 10s, the backend is re-enabled and the next request will again take up to 60s before the backend is marked dead once more. And so on.

By keeping ```proxy_connect_timeout``` low, and ```fail_timeout``` high, this effect can be minimized. When set to respectively 2s and 60s, the backend will be declared dead after 2 seconds, and the will not be checked again for another 60s. At that point, the next request is again stalled 2s until timeout.

# FYI
If you change the loadbalancer config, you can restart it with following command:

```# docker-compose restart loadbalancer```

Note that both web1 and web2 containers need to be running, or the loadbalancer will fail to start due to DNS resolution problems.