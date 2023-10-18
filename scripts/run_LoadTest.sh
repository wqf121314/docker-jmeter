#!/bin/bash
# Clear the contents of the 'report' directory
#rm -rf report/*

# Run JMeter load test
timestamp=$(date +"%Y%m%d_%H%M")
echo "load.threadnum: ${LOAD_THREAD_NUM}"
echo "load.trampup: ${LOAD_TRAMP_UP}"
echo "load.duration: ${LOAD_DURATION}"
./bin/jmeter -n -t ./scripts/LoadTest.jmx -Jload.threadnum=${LOAD_THREAD_NUM} -Jload.trampup=${LOAD_TRAMP_UP} -Jload.duration=${LOAD_DURATION} -l "./report/${timestamp}/result_aggregated.csv" -j "./report/${timestamp}/log.log" -e -o "./report/${timestamp}/HTML"

# Print a message indicating that load testing has been initiated
echo 'Load Testing Finished'
# Keep the script running by tailing /dev/null (this prevents the script from exiting immediately)
tail -f /dev/null