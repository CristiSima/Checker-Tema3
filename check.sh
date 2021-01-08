#!/bin/bash
echo "Checker started"
#echo ""
#echo ""
#echo ""
rm output/*/* &> /dev/null
tests="no_img_loaded_err_P1 no_img_loaded_err_P2 LOAD"
special_tests="SAVE CROP+SELECT ROTATE"
for test in $tests
do
	# echo "Runing test $test"
	mkdir output/$test &>/dev/null
	cat tests/$test/test | ./image_editor > output/$test/stdout 2>/dev/null
	(diff output/$test/stdout tests/$test/stdout &>/dev/null && echo "	$test:	OK") || echo "$test: FAILED"
	# cat tests/$test | ./image_editor
	# cat tests/$test | less
	# rm out
done

for test in $special_tests
do
	mkdir output/$test &>/dev/null
	tests/$test/check.sh 2>/dev/null
done
