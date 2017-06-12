#!/bin/bash
#Rest of spark jobs
    #bin/workloads/ml/kmeans/hadoop/run.sh
    #bin/workloads/sql/scan/spark/run.sh
    #bin/workloads/sql/join/spark/run.sh
    #bin/workloads/sql/aggregation/spark/run.sh
    #bin/workloads/websearch/pagerank/spark/run.sh
    #bin/workloads/ml/kmeans/spark/run.sh


for i in 1 
  do
    #echo "Starting Benchmarks of $1  nodes " >> report/hibench.report
    #Wordcount for spark and hadoop
    bin/workloads/micro/wordcount/spark/run.sh
    bin/workloads/micro/wordcount/hadoop/run.sh
    
    
    bin/workloads/micro/dfsioe/hadoop/run.sh
    bin/workloads/sql/scan/hadoop/run.sh
    bin/workloads/sql/join/hadoop/run.sh
    bin/workloads/sql/aggregation/hadoop/run.sh
    bin/workloads/websearch/pagerank/hadoop/run.sh
    bin/workloads/ml/kmeans/hadoop/run.sh
    
    #Rest of spark jobs
    bin/workloads/sql/scan/spark/run.sh
    bin/workloads/sql/join/spark/run.sh
    bin/workloads/sql/aggregation/spark/run.sh
    #bin/workloads/websearch/pagerank/spark/run.sh
    bin/workloads/ml/kmeans/spark/run.sh
  done


