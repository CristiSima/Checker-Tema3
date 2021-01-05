#!/bin/bash
test="SAVE"
cat tests/$test/test | ./image_editor >out
cumulative=""
if diff out tests/$test/stdout >/dev/null
then
	cumulative="$cumulative OK"
else
	cumulative="$cumulative FAILD"
fi
for file in O_P1 O_P4 O_P2 O_P5 O_P3 O_P6
do
	if diff $file tests/$test/$file >/dev/null
	then
		cumulative="$cumulative	OK"
	else
		cumulative="$cumulative	FAILD"
	fi
done
if echo "$cumulative " | grep "FAILD" >/dev/null
then
	echo "$test: FAILD"
	echo "stdout	P1	P2	P3	P4	P5	P6"
	echo "$cumulative"
	echo
else
	echo "	$test:	OK"
fi
rm O_P1 O_P4 O_P2 O_P5 O_P3 O_P6

rm out
