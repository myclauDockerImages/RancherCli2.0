# RancherCli2.0
allow you to easy use RancherCli for rancher2.x with docker exec, add kubectl available and auto generate kubeconfig but make sure your token have right(update)

# Environment Variable
1. `RANCHER_TOKEN` value schema: `ACCESS-KEY:SECRET-KEY` Default: `null` 
  ```
  !!!Cannot empty!!!
  ```
2. `RANCHER_URL` value schema: `http(s)://xxx.com/v3` Default: `null` 
  ```
  !!!Cannot empty!!!
  ```
3. `RANCHER_CA_CERT`
   1. assume you have a cacert file:
     ```
     -----BEGIN CERTIFICATE-----
     AAA
     BBB
     CCC
     -----END CERTIFICATE-----
     ```
   2. the vaule is `AAABBBCCC`
   3. Default: `null` it is optional 
4. `DEFAULT_PROJECT`
   1. Default: `1`
   2. if you do not know which number is for which project just use 1 first
   3. as in Rancher2.0 version of cli you must select a project as target
   4. to check the number there is 2 way
      1. after you launcher the docker and running
        1. use docker logs container_name
        2. you will see something like
        ```
        NUMBER    CLUSTER NAME   PROJECT ID              PROJECT NAME   
        1         cluster-2      c-7q96s:p-h4tmb         project-2      
        2         cluster-2      c-7q96s:project-j6z6d   Default        
        3         cluster-1      c-lchzv:p-xbpdt         project-1      
        4         cluster-1      c-lchzv:project-s2mch   Default 	
        
        INFO[0005] Setting new context to project project-1
        INFO[0005] Saving config to /Users/markbishop/.rancher/cli2.json
        ```
        3. this number that you can set it to docker-compose and relaunch it again it will default use that project
      2. use `docker exec -it contain_name bash` then run `rancher context switch`
        1. you will see same thing as
        ```
        NUMBER    CLUSTER NAME   PROJECT ID              PROJECT NAME
        1         cluster-2      c-7q96s:p-h4tmb         project-2
        2         cluster-2      c-7q96s:project-j6z6d   Default
        3         cluster-1      c-lchzv:p-xbpdt         project-1
        4         cluster-1      c-lchzv:project-s2mch   Default
        ```
5. `RANCHER_DEFAULT_CLUSTER` 
   1. Default is `null`
   2. If you input the cluster let said `local`
   3. once you start or restart the container it will generate the kubeconfig in to default kubeconfig location `~/.kube/config`
   4. then you can directly use kubectl command i.e `kubectl get nodes`

# How to use
1. after you set docker-compose.yml / docker command with environment
2. run `docker-compose up -d` 
3. or `docker run --name ranchercli  -e .... myclau/ranchercli2:2.0.5`
4. run `docker exec -it ranchercli bash` (with -it) or `docker exec ranchercli rancher ...` (without -it)
5. you can use command `rancher` directly it the session.
