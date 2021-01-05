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
	(diff out tests/$test/stdout >/dev/null && echo "	$test:	OK") || echo "$test: FAILD"
	# cat tests/$test | ./image_editor
	# cat tests/$test | less
	rm out
done

for test in SAVE CROP+SELECT ROTATE
do
	tests/$test/check.sh
done
