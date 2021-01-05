#!/bin/bash
echo "Checker started"
#echo ""
#echo ""
#echo ""
tests="no_img_loaded_err_P1 no_img_loaded_err_P2 LOAD"

for test in $tests
do
	# echo "Runing test $test"
	cat tests/$test/test | ./image_editor > out
	(diff out tests/$test/stdout >/dev/null && echo "	$test: OK") || echo "$test: FAILD"
	# cat tests/$test | ./image_editor
	# cat tests/$test | less
done

test="SAVE"
# echo "Runing test $test"
cat tests/$test/test | ./image_editor >out
cumulative=""
if diff out tests/$test/stdout >/dev/null
then
	cumulative="$cumulative OK"
else
	cumulative="$cumulative FAILD"
fi
(diff out tests/$test/stdout >/dev/null && cumulative="$cumulative OK") || cumulative="$cumulative FAILD"
for file in O_P1 O_P4 O_P2 O_P5 O_P3 O_P6
do
	if diff $file tests/$test/$file >/dev/null
	then
		cumulative="$cumulative	OK"
	else
		cumulative="$cumulative	FAILD"
	fi
	(diff $file tests/$test/$file >/dev/null && cumulative="$cumulative OK") || cumulative="$cumulative FAILD"
done
if echo "$cumulative " | grep "FAILD" >/dev/null
then
	echo "$test: FAILD"
	echo "stdout	P1	P2	P3	P4	P5	P6"
	echo "$cumulative"
	echo
else
	echo "	$test: OK"
fi
rm O_P1 O_P4 O_P2 O_P5 O_P3 O_P6

rm out
