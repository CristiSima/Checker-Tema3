#!/bin/bash
test="CROP+SELECT"
cat tests/$test/test | ./image_editor >out
cumulative=""
if diff out tests/$test/stdout >/dev/null
then
	cumulative="$cumulative OK"
else
	cumulative="$cumulative FAILED"
fi
for file in O1 O2 O3
do
	if diff $file tests/$test/$file >/dev/null
	then
		cumulative="$cumulative	OK"
	else
		cumulative="$cumulative	FAILED"
	fi
done
if echo "$cumulative " | grep "FAILED" >/dev/null
then
	echo "$test: FAILED"
	echo "stdout	O1	O2	O3"
	echo "$cumulative"
	echo
else
	echo "	$test:	OK"
fi

rm O1 O2 O3
rm out
