# Performance Test Scripts
## Introduction
These performance test scripts are focused on XXX products. When executing the script, please ensure `the configurations and initial data` of the environment under test are complete.

These test cases cover the regular operations of users, including User login, Creating Quotations, Search Quotations and User logout. At the end of the task execution, it will be displayed in the project path [. /report], where the detailed results of the execution are stored according to the date of execution.

## Requirement for the environment under test
* Initial data
The project mainly used some test data, including logged-in user data `./data/users.csv`, type data for creating a quotation `./data/load.csv`.

## Execute Configuration
The performance test can be started with the following command:
```shell
# Local Using Jmeter GUI to run
jmeter.sh -t ./LoadTest.jmx

# Non-GUI run
jmeter.sh -n -t ./LoadTest.jmx \
  -Jload.threadnum=10 \
  -Jload.trampup=15 \
  -Jload.duration=600 \
  -Jremote_hosts=localhost:1099 \
  -Jserver.rmi.ssl.disable=true \
  -l ./report/result.csv \
  -j ./report/log.log \
  -e -o ./report/HTML

# The script generates by default the aggregate report and the results tree.
# Convert results into HTML reports
jmeter -g ./report/result_aggregated_{time}.jtl -o ./report/html
```
Introduction parameters. 
  1. load.threadnu: Number of Threads(users),Default 1.
  2. load.trampup: Ramp-up period(seconds),default 15.
  3. load.duration: Duration(seconds),default 600.
  4. load.delay: Startup delay(seconds),default 0.
  5. remote_hosts: The remote hosts.
  6. server.rmi.ssl.disable=true: disables SSL for the RMI communication between the JMeter client and the remote server
