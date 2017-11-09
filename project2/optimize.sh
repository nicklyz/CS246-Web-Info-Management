k1=("0.00" "0.80" "1.20" "1.60" "2.00")
b=("0.00" "0.25" "0.50" "0.75" "1.00")

open=""
close=""

for i in "${k1[@]}"
do
    for j in "${b[@]}"
    do
        curl -XPOST 'localhost:9200/task2/_close?pretty'
        curl -XPUT 'localhost:9200/task2/_settings?pretty' -H 'Content-Type: application/json' -d'
        {
          "settings": {
            "index": {
              "similarity": {
                "default": {
                  "type": "BM25",
                  "k1": "'$i'",
                  "b": "'$j'"
                }
              }
            }
          }
        }'
        curl -XPOST 'localhost:9200/task2/_open?pretty'
        echo 'k1:' $i 'b:' $j
        ./benchmark.sh task2
    done
done
