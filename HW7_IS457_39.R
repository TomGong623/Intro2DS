# Do not remove any of the comments. These are marked by #

# HW 7 - Due Monday Nov 5, 2018 in moodle and hardcopy in class. 

# (1) Upload R file to Moodle with filename: HW7_IS457_YOURCLASSID.R
# (2) Do not remove any of the comments. These are marked by #

## For this assignment we will work with regular expressions. 
## First, we will have some warmup questions, then proceed
## to learn some interesting things about Aesop's fables.

# Part 1.  Regular Expressions Warmup (12 pt)

## Basic Regex

## Q1. Find words in test vector test_1 which start with lowercase 'e' using grep. What does grep return? (2 pt)

test_1 = c("wireless", "car", "energy", "2020", "elation", "alabaster", "Endoscope")

## Your code here
grep("^[e]", test_1)

## Your explanation here
# "grep" returns the indices of matched elements in the vector.


## Q2. Find characters which can be a password with ONLY letters and numbers. (1 pt)

test_2 = c("bb1l9093jak", "jackBlack3", "the password", "!h8p4$$w0rds", "wiblewoble", "ASimpleP4ss", "d0nt_use_this")

## Your code here
grep("^[[:digit:],[:alpha:]]+$",test_2)


## Q3. Find Email addresses of the form letters@letters.xxx (1 pt)
## Here "xxx" means any alpha numeric characters with length of 3.
## Letters can be any alpha numeric characters of any length. Letters before "@" can also be along with the underscore.

test_3 = c("wolf@gmail.com", "little_red_riding_hood@comcast.net", "spooky woods5@swamp.us", "grandma@is.eaten", "the_ax@sbcglobal.net")

## Your code here
grep("^[a-z]+@[a-z]+\\.[a-z0-9]{3}$", test_3)



## Capture Groups
## This is a method to grab specific text within a given match.
## This is a very useful technique to get specific bits of text quickly.
## We will use a series of steps to extract the domain names from properly formatted email addresses.

## Q4. Use regexec() to execute a regular expression to find properly formatted email addresses in test_3. Save it as test_3_reg_exec. 
## This time, we will allow domain names of the form letters.letters. i.e. addresses like 'test.us' are now allowed.(1 pt)

## Your code here
help("regexec")
test_3_reg_exec = regexec("^[a-z]+@[a-z]+\\.[a-z]+$", test_3)

## Q5. What type of object is test_3_reg_exec? What type of information does it contain? (2 pt)

## Your code here
class(test_3_reg_exec)
print(test_3_reg_exec)

## Your explanation here
# "test_3_reg_exec" is a list. It covers 5 elements corresponding to "test_3". In each element, 4 
# sub-elements were contained, including whether this element is matched by pattern or not, the character length
# of the element, data type of the element and whether the elements uses bytes.


## Q6. Use regmatches() to get a list of the text matches from test_3_reg_exec. Call this 'reg_match_list'.
## What is the class of reg_match_list? and what is the format? (4 pt)

## Your code here
help("regmatches") 
reg_match_list = regmatches(test_3, test_3_reg_exec)
reg_match_list
class(reg_match_list)
format(reg_match_list)

## Your explanation here
# "reg_match_list" is a list. It contains the matched email domain names, with unmatched ones as charater(0) elements.


## Q7. Use reg_match_list() to get a vector of matched domain names in Q6. Name this vector 'domain names'. (3 pt)

## Your code here
domain_names = c()
for (i in 1:length(reg_match_list)){
  if (test_3_reg_exec[[i]][1] == 1){
    domain_names = c(domain_names, reg_match_list[[i]][1])
  }
}
domain_names

# Part 2.  Aesop's Fables 

## We will now look at a text file of aesop's fables. We will first need to process the data to get it into a form we can use.
## We can then look at interesting properties like the number of words in each fable.

## Q8. Use readLines() to load the aesop fable data from the aesop-fables.txt file you can find in moodle. 
## Name it aesop_data. MAKE SURE to use the encoding 'UTF-8'. (1 pt)

## Your code here
help("readLines")
conn = file("aesop-fables.txt", open = "r")
aesop_data = readLines(conn, encoding = "UTF-8")




## Q9. What is the format of aesop_data? How is the book formatted? How might we use this formatting to our advantage? (3 pt)

## Your explanation here
class(aesop_data)
format(aesop_data)
tail(aesop_data, 1000)
# "aesop_data" is charaterized list, in which each element represents one line. It starts with some introduction informations,
# followed by a content table, then the fable texts and some ending-up stuff at the tail of the book. This kind of structure 
# could help us to determine which parts of the book are what we are really interested in.


## Q10. Let's take a look of fables using the table of contents.
## First, find the start point and end point of the table of content using grep() and specific header names in the file.
## Then subset only those lines which are from the table of contents.
## Save the fable titles in a character vector.
## Finally, count the number of non-empty lines in your subset. Print out the number.(5 pt)

## Your code here
content_start = as.integer(grep("CONTENT", aesop_data) + 3)
content_end = as.integer(grep("LIST OF ILLUSTRATION", aesop_data) - 5)
Content_table = aesop_data[c(content_start:content_end)]
length(Content_table[Content_table != ""])



## Q11. Separate out all the fables in the file.
## The process is similar to Q10, find the start point and end point. (3 pt)
## Call this fable_data. Here do not remove the titles or empty lines.

## NOTE: Notice that, in this text file, "AESOP'S FABLES" is sometimes shown as "ÆSOP'S FABLES", after you find the lines
## you want to extract information from, make sure you read the text carefully. 
## (if you need to use it, just a simple copy or paste will work).

## Your code here
fable_start = grep("A hungry Fox saw", aesop_data) - 3
fable_end = grep("but on me, Fortune.", aesop_data)
fable_data = aesop_data[c(fable_start:fable_end)]
format(fable_data)


## Q12. How do you know when a new fable is starting? (1 pt)

## Your explanation here
# A new fable usually begins after a title with all capital letters.


## Q13.
## We will now transform this data to be a bit easier to work with.
## Fables always consist of a body which contains consequtive non-empty lines which are the text of the fable.
## This is sometimes followed by a 'lesson' (summary) statement whose lines are consecutive but indented by four spaces.
## We will create a list object which contains information about each fable.

## Get the start positions of each fable in fable_data (how you answer Q12?). (3 pt) 
## Hint: Look at the title vector you created in Q10, what does it include (other than letters?)

## Your code here
start_position = grep("^[A-Z]{2}.*[A-Z]$", fable_data)



## Q14. Transform the fables into an easy-to-reference format (data structure).
## First create a new list object named 'fables'. 
## Each element of the list is a sublist that contains two elements ('text' and 'lesson').

## For each fable, merge together the separate lines of text into a single character element.
## That is, one charactor vector (contains all sentences) for that fable.
## This will be the 'text' element in the sublist for that fable.

## If the fable has a lesson, extract the statement into a character vector (also remove indentation).
## This will be the 'lesson' element in the sublist for that fable. (10 pt)

## Your code here
fables <- list()
for (i in 1:length(start_position)){
  if(i == length(start_position)){
    temp_content <- fable_data[c((start_position[i] + 2):(length(fable_data)))]
    temp_content <- paste(temp_content, collapse = " ", sep = " ")
    temp_list <- list(text = temp_content)
    fables[[i]] <- temp_list
    next
  }
  if(grepl("[[:space:]]{4}[A-Z]", fable_data[start_position[i+1]-5])){
    temp_content <- fable_data[c((start_position[i] + 2):(start_position[i+1]-7))]
    temp_lesson <- fable_data[start_position[i+1]-5]
    temp_lesson = gsub("    ", "", temp_lesson)
    temp_content <- paste(temp_content, collapse = " ", sep = " ")
    temp_list <- list(text = temp_content, lesson = temp_lesson)
  }
  else{
    temp_content <- fable_data[c((start_position[i] + 2):(start_position[i+1]-5))]
    temp_content <- paste(temp_content, collapse = " ", sep = " ")
    temp_list <- list(text = temp_content)
  }
  fables[[i]] <- temp_list
}
fables
## Q15. How many fables have lessons? (2 pt)

## Your code here
tags = unlist(sapply(fables, function(x) names(x)))
lesson_tags = tags[tags == "lesson"]
length(lesson_tags)
# Totally 77 fables have lessons.


## Q16. Add a character count element named 'chars' and a word count element named 'words' to each fable's list. (3 pt)
## Use the following function to count words:

word_count = function(x) {
  return(lengths(gregexpr("\\W+", x)) + 1)  # words separated by space(s)
}
## Your code here
char_count = function(x){
  return(lengths(gregexpr("[[:alnum:][:punct:][:blank:]]", x)))
} 

for (i in 1:length(fables)){
  if (length(fables[[i]]) == 1){
    temp_chars = char_count(fables[[i]]$text)
    temp_words = word_count(fables[[i]]$text)
    fables[[i]]$chars = temp_chars
    fables[[i]]$words = temp_words
  }
  else if (length(fables[[i]]) == 2){
    temp_chars = char_count(fables[[i]]$text) + char_count(fables[[i]]$lesson)
    temp_words = word_count(fables[[i]]$text) + word_count(fables[[i]]$lesson)
    fables[[i]]$chars = temp_chars
    fables[[i]]$words = temp_words
  }
}
fables



## Q17. Create separate histograms of the number of characters and words in the fables. (10 pt)
## Recall the graphics techniques you learned before.
## Your code here
char_numbers = c()
word_numbers = c()
for (i in 1:length(fables)){
  char_numbers = c(char_numbers, fables[[i]]$chars)
  word_numbers = c(word_numbers, fables[[i]]$words)
}
hist(char_numbers, col = "green")
hist(word_numbers, col = 'blue')


## Q18. Let's compare the fables with lessons to those without.
## Extract the text of the fables (from your fables list) into two vectors. One for fables with lessons and one for those without. (4 pt)

## Your code here
With_lesson = c()
Without_lesson = c()
for (i in 1:length(fables)){
  if (length(fables[[i]]) == 3){
    Without_lesson = c(Without_lesson, fables[[i]]$text)
  }
  else if (length(fables[[i]]) == 4){
    With_lesson = c(With_lesson, fables[[i]]$text)
  }
}
length(Without_lesson)
length(With_lesson)


## Q19. Remove all non alphabetic characters (except spaces) and change all characters to lowercase. (3 pt)

## Your code here
Without_lesson = gsub("[[:digit:]]", "", Without_lesson)
Without_lesson = gsub("[[:punct:]]", " ", Without_lesson)
Without_lesson = tolower(Without_lesson)
With_lesson = gsub("[[:digit:]]", "", With_lesson)
With_lesson = gsub("[[:punct:]]", " ", With_lesson)
With_lesson = tolower(With_lesson)
Without_lesson
With_lesson

## Q20. Split the fables from Q19 by blanks and drop empty words. Save all the split words into a single list for each type of fable.
## Name them token_with_lessons and token_without_lessons. Print out their lengths. (5 pt)

## Your code here:
Without_lesson = strsplit(Without_lesson, split = "[[:punct:]]+| +")
Without_lesson = lapply(Without_lesson, function(x) x=x[x != ""])
Without_lesson
With_lesson = strsplit(With_lesson, split = "[[:punct:]]+| +")
With_lesson = lapply(With_lesson, function(x) x=x[x != ""])
With_lesson
token_with_lessons = as.list(unlist(With_lesson))
token_without_lessons = as.list(unlist(Without_lesson))
length(token_with_lessons)
length(token_without_lessons)


## Q21. Calculate the token frequency for each type of fable. (2 pt)

## Your code here:
tf_with_lessons = table(unlist(token_with_lessons))
tf_with_lessons
tf_without_lessons = table(unlist(token_without_lessons))
tf_without_lessons


## Q22. Carry out some exploratory analysis of the data and token frequencies.
## For example, find the words associated fables with lessons. What are distribution patterns for term frequencies?

## Use wordcloud function in wordcloud package to plot your result. What are your observations? (10 pt)

## Hint: you'll want to include important words but not stopwords (we provided a list below) into your plot.
## What are important words? we have token_with(out)_lessons from Q20, think relative high frequency (use quantile() to help you decide).
## so, start by creating a table of token frequency; filter out low frequency words and stopwords.

mask_word = c("by", "as", "a","their", "which", "have", "with", "are", "been", "will", "we", "not",
                "has", "this", "or", "from", "on", "i", "the","is","it","in","my","of","to",
                "and","be","that","for","you","but","its","was")
library(wordcloud)

## Your code here:

tf_with_lessons2 = tf_with_lessons[!names(tf_with_lessons) %in% mask_word]
tf_without_lessons2 = tf_without_lessons[!names(tf_without_lessons) %in% mask_word]
tf_with_lessons3 = quantile(tf_with_lessons2, 0.95)
tf_with_lessons3
tf_with_lessons4 = tf_with_lessons2[tf_with_lessons2 >= 12]
tf_with_lessons4
tf_with_lessons5 = as.vector(tf_with_lessons4)
tf_with_lessons5
tf_without_lessons3 = quantile(tf_without_lessons2, 0.95)
tf_without_lessons3
tf_without_lessons4 = tf_without_lessons2[tf_without_lessons2 >= 16]
tf_without_lessons4
tf_without_lessons5 = as.vector(tf_without_lessons4)
tf_without_lessons5
help("wordcloud")
wordcloud(names(tf_with_lessons4), tf_with_lessons5)
wordcloud(names(tf_without_lessons4), tf_without_lessons5)
## Your explanation here:
# No matter whether the fable is with lesson or not, the top 5 important words are always:
# he, his, him, they, when.
