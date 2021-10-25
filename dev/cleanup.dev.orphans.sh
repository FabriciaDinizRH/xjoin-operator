#!/bin/bash
kubectl get xjoindatasourcepipeline -o custom-columns=name:metadata.name --no-headers | while read -r datasourcepipeline ; do
  kubectl patch xjoindatasourcepipeline "$datasourcepipeline" -p '{"metadata":{"finalizers":null}}' --type=merge
  kubectl delete xjoindatasourcepipeline "$datasourcepipeline"
done

kubectl get xjoindatasource -o custom-columns=name:metadata.name --no-headers | while read -r datasource ; do
  kubectl patch xjoindatasource "$datasource" -p '{"metadata":{"finalizers":null}}' --type=merge
  kubectl delete xjoindatasource "$datasource"
done

kubectl get xjoinindex -o custom-columns=name:metadata.name --no-headers | while read -r index ; do
  kubectl patch xjoinindex "$index" -p '{"metadata":{"finalizers":null}}' --type=merge
  kubectl delete xjoinindex "$index"
done

kubectl get xjoinindexpipeline -o custom-columns=name:metadata.name --no-headers | while read -r indexpipeline ; do
  kubectl patch xjoinindexpipeline "$indexpipeline" -p '{"metadata":{"finalizers":null}}' --type=merge
  kubectl delete xjoinindexpipeline "$indexpipeline"
done

echo "Deleting avro subjects.."
curl localhost:8081/subjects | jq -c '.[]' | while read i; do
    i="${i:1}"
    i="${i::-1}"
    echo "$i"
    curl -X DELETE localhost:8081/subjects/$i
done

echo "Deleting connectors.."
kubectl -n test get KafkaConnector -o custom-columns=name:metadata.name | grep indexpipeline | while read -r connector ; do
    kubectl delete KafkaConnector "$connector" -n test
done
kubectl -n test get KafkaConnector -o custom-columns=name:metadata.name | grep datasourcepipeline | while read -r connector ; do
    kubectl delete KafkaConnector "$connector" -n test
done

echo "Deleting topics.."
kubectl -n test get KafkaTopic -o custom-columns=name:metadata.name | grep indexpipeline | while read -r topic ; do
    kubectl delete KafkaTopic "$topic" -n test
done
kubectl -n test get KafkaTopic -o custom-columns=name:metadata.name | grep datasourcepipeline | while read -r topic ; do
    kubectl delete KafkaTopic "$topic" -n test
done