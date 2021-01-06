#!/bin/bash
test="ROTATE"
cat tests/$test/test | ./image_editor >out
cumulative=""
if diff out tests/$test/stdout >/dev/null
then
	cumulative="$cumulative OK"
else
	cumulative="$cumulative FAILD"
fi
for file in O1 O2 O3 O4 O5 O6 O7 O8 O9
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
	echo "stdout	O1	O2	O3	O4	O5	O6	O7	O8	O9"
	echo "$cumulative"
	echo
else
	echo "	$test:	OK"
fi

rm O1 O2 O3 O4 O5 O6 O7 O8 O9
rm out
