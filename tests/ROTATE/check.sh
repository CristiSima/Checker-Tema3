#!/bin/bash
test="ROTATE"
cat tests/$test/test | ./image_editor >output/$test/stdout
cumulative=""
if diff output/$test/stdout tests/$test/stdout >/dev/null
then
	cumulative="$cumulative OK"
else
	cumulative="$cumulative FAILED"
fi
for file in O1 O2 O3 O4 O5 O6 O7 O8 O9
do
	if diff $file tests/$test/$file >/dev/null
	then
		cumulative="$cumulative	OK"
		rm $file
	else
		cumulative="$cumulative	FAILED"
		mv $file output/$test/
	fi
done
if echo "$cumulative " | grep "FAILED" >/dev/null
then
	echo "$test: FAILED"
	echo "stdout	O1	O2	O3	O4	O5	O6	O7	O8	O9"
	echo "$cumulative"
	echo
else
	echo "	$test:	OK"
fi

# rm O1 O2 O3 O4 O5 O6 O7 O8 O9
