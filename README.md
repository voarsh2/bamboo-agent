# bamboo-agent

Requires script before docker task (e.g. build Dockerfile) in the plan:
```
#!/bin/bash
sudo -S echo "" | sudo -S service docker start
```
