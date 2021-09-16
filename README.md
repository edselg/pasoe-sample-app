# Use the Container Image for PAS for OpenEdge 12.2.1 with a Sample Application

## Requirements:
* Docker environment
* Docker Compose
* A valid progress.cfg file
* OpenEdge 12.2.1 Environment
* Scripts to deploy Progress Application Server for OpenEdge Container. This can be obtained either from the Progress Download Center or Progress communities.

Note: For the deployment, we are using service port 8811(sample-app), 9200(elasticsearch), 5601(kibana) and 8080(web-ui). These ports should be available.

## Use the Container Image

1. Start a database server if you don't have a running database server. Below is an example
     * Create a copy of the sports2000 database and start the database server (broker)
        * `prodb sports sports2000`
        * `proserve sports -S <DB_PORT>`

2. Build the Sports sample app:
     * cd Sports
     * For connecting to the database, update the ./conf/startup.pf file with the below content and substituting the required field.
        * `-db sports -H <IP_ADDRESS_OF_DB_HOST> -S <DB_PORT>`
     * In an openedge environment, run the below command
        * `ant package`
        * Note: A Sports.zip file is generated in ./output/package-output
     * Change the working directory to the parent to follow  further steps
        * `cd ..`

3. Start the Elasticsearch, Kibana and web-ui service
     * Update the value for `serviceURI` in `webui/grid.js` to point to your Docker host.
     * Increase virtual memory settings to run Elasticsearch:
        * `sudo sysctl -w vm.max_map_count=262144`
        * For additional info : https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
     * Start the services
        * `docker-compose up -d`
     * Check the status of Elasticsearch via a web browser. Elasticsearch may take some time to start.
        * `http://<docker-host-machine>:9200`
     * Check the Elasticsearch starts:
        * `docker-compose logs -f elasticsearch`

4. Deploy the sample app in PASOE
     * Download the PASOE image zip from Electronic Software Distribution (ESD) and unzip it to a folder say `pasoe-sample-app`.
       For more details, refer https://docs.progress.com/bundle/pas-for-openedge-docker/ 
     * Change the directory
        * `cd pasoe-sample-app`
     * Copy the Sports.zip generated from Step 2 to `./deploy/ablapps`
        * `cp ../Sports/output/package-output/Sports.zip ./deploy/ablapps/`
     * Copy the config.properties  from sample app to `./deploy/config.properties`
        * `cp ../config.properties ./deploy/config.properties`
     * Update the value for `HOST` in `../fluentbit/conf/fluent-bit-output.conf` to point to your Elasticsearch host.
     * Copy the Fluent Bit config from sample app to push the logs to Elasticsearch
        * `cp ../fluentbit/conf/fluent-bit-output.conf ./deploy/conf/logging/`
     * Copy the license file `progress.cfg` to `./deploy/license`
     * If you want to change the database during deployment, you can do this by updating the ./deploy/conf/runtime.properties with below content and substituting the requied field. If `localhost` is used in Step 2 for connecting to the database, please do update the ./deploy/conf/runtime.properties to point to the IP_ADDRESS_OF_DB_HOST.
       * `Sports.DB.CONNECTION.PARAMS=-db sports -H <IP_ADDRESS_OF_DB_HOST> -S <DB_PORT>`
     * Deploy the sample app
       * `ant -f ./deploy/build.xml deploy`
5. Access the PAS for OpenEdge instance via a web browser:
     * `https://<docker-host-machine>:8811/`
     * `https://<docker-host-machine>:8811/Sports/`
     * `https://<docker-host-machine>:8811/Sports/static/SportsService.json`
     * `https://<docker-host-machine>:8811/Sports/rest/SportsService/Customer`
     * Note: By default, the PAS for OpenEdge instance will use HTTPS with a test certificate. You will need to accept access with this certificate.

6. Access the web-ui service via a web browser:
     * `http://<docker-host-machine>:8080`

7. Access Elasticsearch to check on available logs
     * `http://<docker-host-machine>:9200/_cat/indices`

8. Access Kibana
     * `http://<docker-host-machine>:5601`
     * Notes:
         * Select Management/Index Management to see the indices in Elasticsearch.A index named as `pasoe-container-logs` should be present.
         * Select Management/Index Pattern to create an index for Kibana:
             * Create index patterns as 'pasoe_container*'
             * Specify @timestamp to filter data by time
             * Select Discover to see pasoe logs. You can search logs for logtype:
                  * pasoe_agent_log, pasoe_application_log, pasoe_localhost_log, pasoe_localhost_access_log, start_server_log and etc.

9. Stop the running services 
     * Stop Elasticsearch, Kibana, and web-ui
        * `docker-compose -f ../docker-compose.yaml down`
     * Stop deployed sample app
        * `ant -f ./deploy/build.xml undeploy`


     
