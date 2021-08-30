# HSV5: HTML5 Seperated Values

There was a recent [discussion](https://news.ycombinator.com/item?id=28221654) on Hacker News on an article [Time to retire the CSV? (bitsondisk.com)](https://www.bitsondisk.com/writing/2021/retire-the-csv/).
The article makes many excellent points. CSV and it's related family have fundamental problems largely related to lack of formal specification and missing metadata.

However, text formats are often much nicer to use than binary files.
It's easy to open a file in almost any language, do a `line.split('\t')` and be able to import data.
A CSV alternative based on ASCII control codes would resolve many of the problems of either escaping or wrapping the delimiter character. 
Unfortunately it doesn't resolve the lack of metadata which is another major drawback of any character based separator files.
What can we do? 

This repo explores the concept of an `HTML5` based alternative to CSV, TSV, JSONL.
Mostly it's a scratchpad for an idea of re-using modern HTML5 for a CSV alternative. 
