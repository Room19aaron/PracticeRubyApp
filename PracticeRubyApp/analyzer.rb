#ANALYZER.RB -- TEXT ANALYZER
stopwords = %w{the a by on for of are with just but and to the my I has some in}
lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join

#COUNT THE CHARACTERS
character_count = text.length
character_count_nospace = text.gsub(/\s+/,"").length

#COUNT THE WORDS, SENTENCES AND PARAGRAPHS
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

#MAKE A LIST OF WORDS IN THE TEXT THAT AREN'T STOPWORDS
#COUNT THEM, AND WORK OUT THE PERCENTAGE OF NON-STOPWORDS
#AGAINST ALL WORDS
all_words = text.scan(/\w+/)
good_words = all_words.select{ |word| !stopwords.include?(word) }
good_percentage = ((good_words.length.to_f / all_words.length.to_f) * 100).to_i

#SUMMARIZE THE TEXT BY CHERRY PICKING SOME CHOICE SENTENCES
sentences = text.gsub(/\s+/,' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length}
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third+1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

#GIVE AN ANALYSIS BACK TO THE USER
puts "#{line_count} lines"
puts "#{character_count} characters"
puts "#{character_count_nospace} characters excluding spaces"
puts "#{word_count} words"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count} sentences"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "Summary:\n\n" + ideal_sentences.join(". ")
puts "--End of analysis"
