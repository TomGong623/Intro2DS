#!/bin/bash


# HW 9 - Due Monday Dec 3, 2018 in moodle.

# Upload .sh file to Moodle with filename: HW9_457IDS_YOURCLASSID.sh

# Please make sure all the commends work well in WholeTale, we will test your script.

# In your hard copy report, please include the UNIX / Linux script, input arguments, and results.

# There are multiple solutions for this homework. The grading will be based on the successful running of your code and the correct output as we specified. We will grade your homework on WholeTale.

# For this assignment we will use some basic commends of UNIX / Linux.  
# The text Hw_9.txt & adult.csv are uploaded to Moodle.
# You can use "text file" editor to edit HW9_457IDS_YOURCLASSID.sh and run in "Terminal".

# You can use the following commands to run the script (for example on google cloud):
# chmod +x HW9_457IDS_YOURCLASSID.sh
# ./HW9_457IDS_YOURCLASSID.sh Argument_1 Argument_2 Argument_3 Argument_4 

# Here is a list of your input arguments:
# Argument_1: a positive number
# Argument_2: a lowercase word
# Argument_3: text file ( .txt)
# Argument_4: a positive integer which is less than 15


# Q1 (2pts). Check whether your input integer(Argument_1) is even or odd
#     and print your result. (5 points)
echo "************ Q1 ************"
# Your answer here:
a=$(($1 % 2))
if [$a -eq 0]
then echo "$1 is even"
else echo "$1 is odd"
fi
# Q2 (2pts). Input a lowercase letter(Argument_2) and convert it to uppercase and print your result. (5 points)
#     (Hint: tr)
echo "************ Q2 ************"
# Your answer here:
Upper=$(echo $2 | tr '[a-z]' '[A-Z]')
echo "Upper case of $2 is $Upper"
# Q3 (2pts). Convert the following phrase "CS 398/IS 457:INTRODUCTION
#     TO DATA SCIENCE" into separate words, and put each word on its own
#     line (ignoring space,'/' and ':'). (5 points)
# The output looks like:
# CS
# 398
# IS
# 457
# INTRODUCTION
# TO
# DATA
# SCIENCE
echo "************ Q3 ************"
# Your answer here:
Var_input="CS 398/IS 457:INTRODUCTION TO DATA SCIENCE"
Var_output=$(echo $Var_input | tr '[[:punct:][:space:]]' 'bbb')
Var_output=${Var_input//\ /\\n}
Var_output=${Var_output//:/\\n}
Var_output=${Var_output//\//\\n}
echo -e $Var_output
# Q4 (2pts). Sort the answer in Q3 by descending order. (5 points)
# The output would look like:
# TO
# SCIENCE
# IS
# INTRODUCTION
# DATA
# CS
# 457
# 398
echo "************ Q4 ************"
# Your answer here:
echo -e $Var_output | sort -r
# Q5 (2pts). Count the lines of your text file(Argument_3). (5 points)
#     (Hint: wc)
echo "************ Q5 ************"
echo "The number of lines in $3 is:"
# Your answer here:
Var_line=$(wc -l $3)
echo -e $Var_line
# Q6 (2pts). Count the frequency of a input word(Argument_2) in a text
#     file(Argument_3), and print "The frequency of word ____ is ____ ".
#     (5 points)
#     (Hint: grep)
echo "************ Q6 ************"
echo "The frequency of word $2 is:"
# Your answer here:
Var_fre=$(grep -o $2 $3 | wc -l)
echo $Var_fre
# Q7 (2pts). Print the number of unique words in the text file(Argument_3).
#     (5 points) 
#     (Hint: uniq, sort) 
echo "************ Q7 ************"
echo "The number of unique words in the text file:"
# Your answer here:
grep -oE '\w+' $3 | sort | uniq -c | wc -l
# Q8 (2pts). Print the number of words that begin with the letter 'b' in the
#     text file(Argument_3) (5 points).
echo "************ Q8 ************"
echo "The number of words that begin with letter 'b':"
# Your answer here:
grep -oE '\bb(\w)*' $3 | wc -l
# Q9 (2pts). Print top-k(Argument_4) and find the most frequent word and their frequencies.
#      (5 points).
#      (Hint: head) 
echo "************ Q9 ************"
echo "Top-$4 words are:"
# Your answer here:
grep -oE '\w+' $3 | sort | uniq -c | sort -nr | head -$4
# Q10 (4pts). The dataset adult-income.csv provides some clean records of adults to predict whether income exceeds $50K/yr. For details, visit the UCI repository.
# Calculate how many categories are there in "workclss" (2nd column) and print your result. (5 points)
#     (Hint: awk)
echo "************ Q10 ************"
Var_result=$(awk -F, 'NR >= 2 {count[$2]++}END{for(i in count)print i":"count[i]"\\n"}' adult-income.csv)
echo -e $Var_result
# Q11 (4pts). For your output in Q10, change the format of categories. Replace "-" with "_".
# (Hint: sed)
# The output would look like:
# Private 22696
# Local-gov 2093
# State-gov 1298
# ...
echo "************ Q11 ************"
# Your answer here:
echo -e $Var_result | sed -e 's/\-/_/g'