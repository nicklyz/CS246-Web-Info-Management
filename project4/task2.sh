#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "usage: task2.sh <corpus dir> <number of topics>"
    exit 1
fi

INPUT_DIR=$1
NUM_TOPICS=$2

mallet import-dir --input $INPUT_DIR --output data.mallet --keep-sequence --remove-stopwords

mallet train-topics --input data.mallet --num-topics $NUM_TOPICS --output-topic-keys topic-words.txt --output-doc-topics doc-topics.txt

echo "This script should read files in $INPUT_DIR, perform LDA with $NUM_TOPICS topics, and create two output files:"
echo '  topic-words.txt: "topic-keys" file (topic number followed by top-20 associated words)'
echo '  doc-topics.txt: "doc-topics" file (document # and filename followed by the topic probabilities)'
