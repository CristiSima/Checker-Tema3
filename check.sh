#!/bin/bash
echo "Checker started"
#echo ""
#echo ""
#echo ""
rm output/*/* &> /dev/null
tests="no_img_loaded_err_P1 no_img_loaded_err_P2 LOAD"

for test in $tests
do
	# echo "Runing test $test"
	cat tests/$test/test | ./image_editor > output/$test/stdout
	(diff output/$test/stdout tests/$test/stdout >/dev/null && echo "	$test:	OK") || echo "$test: FAILED"
	# cat tests/$test | ./image_editor
	# cat tests/$test | less
	# rm out
done

for test in SAVE CROP+SELECT ROTATE
do
	tests/$test/check.sh
done
