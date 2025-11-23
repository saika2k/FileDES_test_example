#!/bin/bash

DIR_NAME="paths"

FILE_NAME="aggregate_number"

NUMBER=4

echo "$NUMBER" > "./$DIR_NAME/$FILE_NAME"

./lotus client import testdata/v1.pptx

./lotus client import testdata/patch1

./lotus client import testdata/patch2

./lotus client import testdata/patch3


./lotus client deal bafk2bzacedket5b24hwaoysox4y7yyhjmyozehpmt6tjq2z4pyxx25rtxybpq t01000 0.026 518400
sleep 30

./lotus client deal bafk2bzacebqgkmh7ytjryviithv7pnbeivx7i5qahv4gyxwbzv2h7gwg5lvuw t01000 0.026 518400
sleep 30

./lotus client deal bafk2bzacedp66ftn6os4f3vzgee6yvjozxyshbph6s77tptucgnfiqwr6dek6 t01000 0.026 518400
sleep 30

./lotus client deal bafykbzacebkyd76tunr2zajzaehasssft6bp4op4vfowohzpwuut3sm4yn77q t01000 0.026 518400

