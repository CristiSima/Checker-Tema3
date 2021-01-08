#!/bin/bash
test="SAVE"
cat tests/$test/test | ./image_editor >output/$test/stdout
cumulative=""
if diff output/$test/stdout tests/$test/stdout >/dev/null
then
	cumulative="$cumulative OK"
else
	cumulative="$cumulative FAILED"
fi
for file in P1_P1 P1_P4 P2_P2 P2_P5 P3_P3 P3_P6 P4_P1 P4_P4 P5_P2 P5_P5 P6_P3 P6_P6
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
	echo "stdout	P1_P1	P1_P4	P2_P2	P2_P5	P3_P3	P3_P6	P4_P1	P4_P4	P5_P2	P5_P5	P6_P3	P6_P6"
	echo "$cumulative"
	echo
else
	echo "	$test:	OK"
fi
# rm O_P1 O_P4 O_P2 O_P5 O_P3 O_P6
